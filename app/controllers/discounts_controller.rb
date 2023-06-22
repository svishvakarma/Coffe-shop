class DiscountsController < ApplicationController
	skip_before_action :verify_authenticity_token
  before_action :get_discount, only: [:create, :update]

  def index
    @discounts = Discount.all
    render json: @discounts.all.map {|discount| DiscountSerializer.new(discount).serializable_hash }
  end

  def show 
    @discount = Discount.find(params[:id])
    render json: DiscountSerializer.new(@discount).serializable_hash, status: 200 
  end 

  def create
    @order = Order.find(params['order_id'])
    @discount = Discount.new(discount_params)
    @discount.total_amount = @discounted_price 
    if @discount.save 
      render json: DiscountSerializer.new(@discount).serializable_hash, status: 200 
    else 
      render json: { message: 'error' }
    end 
  end 

  def update
    @discount = Discount.find(params[:id])
    if @discount.update(discount_params)
      @discount.total_amount = @discounted_price 
      render json: DiscountSerializer.new(@discount).serializable_hash, status: 200 
    else
      render json: OrderSerializer.new(@discount).serializable_hash, status: :unprocessable_entity
    end
  end  

  def destroy 
    @discount = Discount.find(params[:id])
    if @discount.destroy
      render json: {message: ' discount deleted succesfully'}
    else 
      render json: DiscountSerializer.new(@discount).serializable_hash, status: :unprocessable_entity
    end  
  end 
    
  private 

  def discount_params
    params.require(:discount).permit(:total_quantity,:total_price,:order_id,:order_id)
  end 
  
  def get_discount
    if params[:total_quantity]!=  1
      @discounted_price = params[:total_price]/2
    else
      render json: {message: 'error'}
    end 
  end  
end
