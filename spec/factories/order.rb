FactoryBot.define do
  factory :order, class: 'Order' do
    customer_id { 1 }
    email {Faker::Internet.email}
    address { "djklhadh" }
  end

  factory :order_items, class: 'OrderItem' do 
    product_id { 1 } 
    quantity { 3756 } 
  end   
end
  
  