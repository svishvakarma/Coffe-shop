class CreateDiscounts < ActiveRecord::Migration[6.0]
  def change
    create_table :discounts do |t|
      t.integer :total_amount
      t.integer :total_price
      t.integer :total_quantity
      t.decimal :percentage
      t.belongs_to :order
      
      t.timestamps
    end
  end
end
