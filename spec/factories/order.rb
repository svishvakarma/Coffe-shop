FactoryBot.define do
 
  factory :order, class: 'Order', parent: :customer do 
    customer { FactoryBot.create(:customer) }
    customer_id { 1 }
    email {Faker::Internet.email}
  end

  factory :order_items, class: 'OrderItem' do 
    product_id { 1 } 
    quantity { 3756 } 
  end   

end
  
  