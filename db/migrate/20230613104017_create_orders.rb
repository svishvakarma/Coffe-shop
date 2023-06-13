class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :total_price
      t.references :customer
      t.timestamps
    end
  end
end
