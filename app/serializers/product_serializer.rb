include ActiveModel::Serialization
class ProductSerializer < ActiveModel::Serializer
  attributes *[
    :id,
    :name,
    :description,
    :price
  ]

end

