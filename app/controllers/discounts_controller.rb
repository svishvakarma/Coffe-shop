class DiscountsController < ApplicationController
	skip_before_action :verify_authenticity_token
	before_action :get_discount

	def create
		@order = Order.find(params['order_id'])
		
		@discount = Discount.new(
			total_price: params[:total_price], 
			total_quantity: params[:total_quantity],
			order_id: params[:order_id],
			order_item_id: params[:order_item_id]     
		)
		@discount.total_amount = @discounted_price 
		if  @discount.save 
			render json: { message: @discount }
		else 
			render json: { message: 'error' }
		end 
	end 

	private 

	def discount_params
	end 
	
	def get_discount
		if params[:total_quantity] > 1
			@discounted_price = params[:total_price]/2
		else
			render json: {message: 'error'}
		end 
	end 
end
