class OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :get_order_items, only: [:create, :update]
  before_action :find_rate, only: [:create, :update]

  def index
    @orders = Order.all
    render json: @orders.map { |order| OrderSerializer.new(order).serializable_hash }
  end

  def show
    @order = Order.find(params[:id])
    render json: OrderSerializer.new(@order).serializable_hash, status: 200
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      @order.total_price = @total_price
      OrderMailerJob.perform_later(@order)
      render json: OrderSerializer.new(@order).serializable_hash, status: 200
    else
      render json: { message: 'error' }
    end
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      @order.total_price = @total_price
      render json: OrderSerializer.new(@order).serializable_hash, status: 200
    else
      render json: OrderSerializer.new(@order).serializable_hash, status: :unprocessable_entity
    end
  end

  def destroy
    @order = Order.find(params[:id])
    if @order.destroy
      render json: { message: 'order deleted successfully' }
    else
      render json: OrderSerializer.new(@order).serializable_hash, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.permit(:total_price, :customer_id, :email, :tax_amount, :discount_amount, order_items_attributes: [:product_id, :quantity])
  end

  def get_order_items
    if params.dig(:order_items_attributes, 0, :product_id)
      product = Product.find(params.dig(:order_items_attributes, 0, :product_id))
      rate = find_rate
      @total_price = product.price * params.dig(:order_items_attributes, 0, :quantity) + rate
    end
  end

  def find_rate
    product = Product.find(params.dig(:order_items_attributes, 0, :product_id))
    tax_rate = TaxRate.find(product.tax_rate_id)
    @tax = tax_rate.rate
  end
end
