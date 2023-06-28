FactoryBot.define do

  factory :discount, class: 'Discount', parent: :order do
    # customer { FactoryBot.create(:customer) }
    order { create(:order)}
    total_price { 203445} 
    total_quantity { 45 }
    percentage  { 5 }
  end
end
  
  