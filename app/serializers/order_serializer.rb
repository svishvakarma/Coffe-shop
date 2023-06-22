include ActiveModel::Serialization
class OrderSerializer < ActiveModel::Serializer
  attributes :customer_id, :email, :order_items

  attributes :order_items do |object|
    object.order_items
  end
end
