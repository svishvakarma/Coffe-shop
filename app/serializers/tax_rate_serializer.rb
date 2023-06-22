include ActiveModel::Serialization
class TaxRateSerializer < ActiveModel::Serializer
  attributes *[
    :id,
    :name,
    :rate
  ]
  
end