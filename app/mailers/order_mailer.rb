class OrderMailer < ApplicationMailer
	def order_mail(object)
    byebug 
		@object = object 
		mail(to: @object.email, subject: 'Thanks for visit us..')
	end   
end