class PaymentsController < ApplicationController
	skip_before_action :verify_authenticity_token

	def index
		@payments = Payment.all 
	end 

	def create
		@order = Order.find(params['order_id'])
		@payment = Payment.new(
			make_payment: params[:make_payment],
			email: params[:email],
			order_id: params[:order_id
			]   
		)
		if @order.discount[:total_quantity] > 1
			@discounted_price = @order.discount[:total_price]/2
			@order.discount.update("total_amount": @discounted_price )
		end 
		if @order.discount[:total_amount] == params[:make_payment]
		@payment.save 
		debugger
		PaymentMailer.sent_mail_payment_success(@payment).deliver_now

		render json: { message: 'payment successfull' }
		else 
		render json: { message: 'something went wrong' }
		end 
	end 
		
	private 
	
	def payment_params
		params.require(:payment).permit(:total_amount, :make_payment,:email, :order_id)
	end 
end
