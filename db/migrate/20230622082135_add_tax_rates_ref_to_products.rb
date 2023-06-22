class AddTaxRatesRefToProducts < ActiveRecord::Migration[6.0]
  def change
    add_reference :products, :tax_rate, foriegn_key: true
  end

end
