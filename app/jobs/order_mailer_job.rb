class OrderMailerJob < ApplicationJob
  queue_as :default
  
  def perform(*args)
    OrderMailer.order_mail(args.first).deliver_later(wait: 1.minute)
  end
end
