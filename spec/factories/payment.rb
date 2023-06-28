FactoryBot.define do
  factory :payment, class: 'Payment' do
    order_id { 1 }
    make_payment { 34 }
    email {Faker::Internet.email}

  end
end

