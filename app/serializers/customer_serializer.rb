include ActiveModel::Serialization
class CustomerSerializer < ActiveModel::Serializer
  attributes *[
    :id,
    :name,
    :email,
    :address,
    :pincode
  ]
end