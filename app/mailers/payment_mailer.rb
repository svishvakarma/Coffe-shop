class PaymentMailer < ApplicationMailer
	def sent_mail_payment_success(object)
		@object = object 
		mail(to: @object.email, subject: 'payment is done')
	end  
end  
