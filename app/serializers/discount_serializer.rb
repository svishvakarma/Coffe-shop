include ActiveModel::Serialization
class DiscountSerializer < ActiveModel::Serializer
  attributes *[
    :id,
    :order_id,
    :total_amount,
    :total_price,
    :total_quantity,
    :percentage
  ]

end