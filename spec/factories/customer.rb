FactoryBot.define do
  factory :customer, class: 'Customer' do
    name { "NewNmae" }
    email {Faker::Internet.email}
    address { "djklhadh" }
    pincode { 1 }
  end
end

