include ActiveModel::Serialization
class OrderSerializer < ActiveModel::Serializer
  attributes :id,:customer_id, :email,:total_price, :product


  def product
    object.order_items.map do |item|
      product = Product.find(item.product_id,)
      {
        id: product.id,
        name: product.name,
        description: product.description,
        price: product.price
      }  
    end

  end

end
