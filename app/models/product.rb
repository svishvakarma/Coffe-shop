class Product < ApplicationRecord
  belongs_to :tax_rate, optional: true   
end
