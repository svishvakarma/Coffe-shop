class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :customer
      t.string :total_price
      t.date :order_date
      t.decimal :tax_amount
      t.decimal :discount_amount 
      t.timestamps
    end
  end
end



