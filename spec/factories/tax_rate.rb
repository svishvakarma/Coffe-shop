FactoryBot.define do
  factory :tax_rate, class: 'TaxRate' do
    name { "NewNmae" } 
    rate { '4' }
  end
end

