class RemoveColumnsToOrderItems < ActiveRecord::Migration[6.0]
  def change
    remove_column :order_items, :name
    remove_column :order_items, :description
    remove_column :order_items, :price

  end
end
