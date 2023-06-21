class OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :order_items
  
  def index
    @orders = Order.all
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
  
  private

  def order_params
    params.permit(:total_price,:customer_id,:email,order_items_attributes: [:id,:name,:price,:description,:quantity])
  end
  
  def order_items
    if params[:order_items_attributes].present?
      @total_price = params[:order_items_attributes].first['price'] * params[:order_items_attributes].first['quantity']
    else 
      render json: {message: 'something wrong'}
    end 
  end 
end
