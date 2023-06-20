class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.string :email
      t.belongs_to :order
      t.integer :total_amount
      t.integer :make_payment
      t.timestamps
    end
  end
end
