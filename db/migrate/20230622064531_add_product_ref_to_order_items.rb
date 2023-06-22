class AddProductRefToOrderItems < ActiveRecord::Migration[6.0]
  def change
    add_reference :order_items, :product, foriegn_key: true
  end
  
end
