class CreateOrderItems < ActiveRecord::Migration[6.0]
  def change
    create_table :order_items do |t|
      t.string :name
      t.string :description
      t.string :price
      t.integer :quantity

      t.timestamps
    end
  end
end

