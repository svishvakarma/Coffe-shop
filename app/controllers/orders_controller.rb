class OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token
  # before_action :get_order_items, only: [:create]
  
  def index
    @orders = Order.all
    render json: @orders.all.map{ |order| OrderSerializer.new(order).serializable_hash} 
  end

  def show 
    @order = Order.find(params[:id])
    render json: OrderSerializer.new(@order).serializable_hash, status: 200 
  end 

  def create
    @order = Order.new(order_params)
    if @order.save
      @order.total_price = @total_price
      OrderMailer.order_mail(@order).deliver_now
      render json: OrderSerializer.new(@order).serializable_hash, status: 200 
    else
      render json: {message: 'error'}
    end
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      render json: OrderSerializer.new(@order).serializable_hash, status: 200 
    else
      render json: OrderSerializer.new(@order).serializable_hash, status: :unprocessable_entity
    end
  end

  def destroy 
    @order = Order.find(params[:id])
    if @order.destroy
      render json: {message: ' order deleted succesfully'}
    else 
      render json: OrderSerializer.new(@order).serializable_hash, status: :unprocessable_entity
    end  
  end 
  
  private

  def order_params
    params.permit(:total_price,:customer_id,:email, order_items_attributes: [:product_id,:quantity])
  end
  
  # def get_order_items
  #   if params[:order_items_attributes].present?
  #     @total_price = params[:order_items_attributes].first['price'] * params[:order_items_attributes].first['quantity']
  #   else 
  #     render json: {message: 'something wrong'}
  #   end 
  # end 
end
