class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :email
      t.string :address
      t.integer :pincode
      t.timestamps
    end
  end
end
