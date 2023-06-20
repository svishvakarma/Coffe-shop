class OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def index
    @orders = Order.all
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      OrderMailer.order_mail(@order).deliver_now
      render json: {message: @order}
     else
     render json: {message: 'error'}
    end
  end
  
  private

  def order_params
    params.permit(:total_price,:customer_id,:email,order_items_attributes: [:id,:name,:price,:description,:quantity])
  end
end
