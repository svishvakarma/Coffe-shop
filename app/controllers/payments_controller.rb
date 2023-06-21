class PaymentsController < ApplicationController
	skip_before_action :verify_authenticity_token

	def index
	  @payments = Payment.all
	  render json: @payments.all.map{ |payment| OrderSerializer.new(payment).serializable_hash } 
	end 
  
	def show 
	  @payment = Payment.find(params[:id])
	  render json: PaymentSerializer.new(@payment).serializable_hash, status: 200 
	end 
  
	def create
	  @order = Order.find(params['order_id'])
	  @payment = Payment.new(payment_params)   
	  if @order.discount[:total_quantity] > 1
			@discounted_price = @order.discount[:total_price]/2
			@order.discount.update("total_amount": @discounted_price )
	  end 
	  if @order.discount[:total_amount] == params[:make_payment]
			@payment.save 
			PaymentMailer.sent_mail_payment_success(@payment).deliver_now
			render json: { message: 'payment successfull' }
	  else 
			render json: PaymentSerializer.new(@payment).serializable_hash, status: :unprocessable_entity
	  end 
	end 
  
	def update
	  @payment = Payment.find(params[:id])
	  if @payment.update(payment_params)
			render json: PaymentSerializer.new(@payment).serializable_hash, status: 200 
	  else
			render json: PaymentSerializer.new(@payment).serializable_hash, status: :unprocessable_entity
	  end
	end
  
	def distroy 
	  @payment = Payment.find(params[:id])
	  if @payment.destroy
			render json: {message: ' payment deleted succesfully'}
	  else 
			render json: PaymentSerializer.new(@payment).serializable_hash, status: :unprocessable_entity
	  end  
	end 
	  
	private 
	
	def payment_params
	  params.require(:payment).permit(:total_amount, :make_payment,:email, :order_id)
	end 
end
