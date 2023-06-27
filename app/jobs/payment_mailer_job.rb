class PaymentMailerJob < ApplicationJob
  queue_as :default
  
  def perform(*args)
    PaymentMailer.sent_mail_payment_success(args.first).deliver_now
  end

end
