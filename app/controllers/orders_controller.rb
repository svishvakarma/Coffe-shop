class OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :get_order_items, only: [:create, :update]

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
    @order.total_price = @total_price
    if @order.save!
      OrderMailerJob.perform_later(@order)
      render json: OrderSerializer.new(@order).serializable_hash, status: 201
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
    params.require(:order).permit(:total_price, :customer_id, :email, :tax_amount, :discount_amount, order_items_attributes: [:product_id, :quantity])
  end

  def get_order_items
    if params.dig(:order_items_attributes, 0, :product_id)
      product = Product.find(params.dig(:order_items_attributes, 0, :product_id))
      rate = find_rate
      @total_price = product.price * params.dig(:order_items_attributes, 0, :quantity) + rate
    end
  end

end
