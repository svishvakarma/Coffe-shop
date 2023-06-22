class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  has_one :payment
  has_one :discount 
  belongs_to :customer, optional: true 
  accepts_nested_attributes_for :order_items
end
