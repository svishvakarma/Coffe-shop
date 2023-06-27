class OrderMailer < ApplicationMailer
	def order_mail(object)
		@object = object 
		mail(to: @object.email, subject: 'Thanks for visit us..')
	end   
end