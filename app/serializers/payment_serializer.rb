include ActiveModel::Serialization
class PaymentSerializer < ActiveModel::Serializer 
  attributes *[
    :id, 
    :order_id,
    :total_amount,
    :make_payment
  ]

end