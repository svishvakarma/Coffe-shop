include ActiveModel::Serialization
class ProductSerializer < ActiveModel::Serializer
  attributes *[
    :id,
    :name,
    :description,
    :price,
    :tax_rate_id
  ]

end

