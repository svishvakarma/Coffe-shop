class PaymentsController < ApplicationController
	skip_before_action :verify_authenticity_token
  
	def index
	  @payments = Payment.all
	  # render json: @payments.map { |payment| OrderSerializer.new(payment).serializable_hash }
	    render json: @payments 
  end
  
	def show
	  @payment = Payment.find(params[:id])
	  render json: PaymentSerializer.new(@payment).serializable_hash, status: :ok
	end
  
	def create
	  @order = Order.find(params['order_id'])
	  if @order.payment.present?
		  render json: { message: "Already payment success" }
	  else
      @payment = @order.build_payment(payment_params)
      if check_payment_and_send_mail
        @payment.save
		    PaymentMailerJob.perform_later(@payment)
        render json: { message: "Payment success" }
      else
        render json: PaymentSerializer.new(@payment).serializable_hash, status: :unprocessable_entity
      end
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
  
	def destroy
	  @payment = Payment.find(params[:id])
	  if @payment.destroy
		  render json: { message: 'payment deleted successfully' }
	  else
		  render json: PaymentSerializer.new(@payment).serializable_hash, status: :unprocessable_entity
	  end
	end
  
	private
  
	def payment_params
	  params.require(:payment).permit(:total_amount, :make_payment, :email, :order_id)
	end
  
	def check_payment_and_send_mail 
	  if @order.discount[:total_amount] == params[:make_payment]
		  # PaymentMailer.sent_mail_payment_success(@payment).deliver_now
		  # PaymentMailerJob.set(wait: 1.minutes).perform_later#(@payment)

      true
	  else
		  false
	  end
	end
end
