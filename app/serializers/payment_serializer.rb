include ActiveModel::Serialization
class PaymentSerializer < ActiveModel::Serializer 
  attributes *[
    :id, 
    :order_id,
    :make_payment
  ]

end