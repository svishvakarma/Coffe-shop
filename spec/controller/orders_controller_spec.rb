require "rails_helper"
RSpec.describe OrdersController, type: :controller do
  let(:customer) { FactoryBot.create(:customer)}
  let(:order) { FactoryBot.create(:order) } 
  
  context "when valid" do
    before(:each) do
      post :create, params: { email: "dj@gmail.com",customer_id: customer.id,
        order_items: attributes_for(:order_items, quantity: 7348, product_id: product.id,
          order_items_attributes: [build(:order_items).attributes]
        )
      }
    end

  end 

  describe "#index" do
    it "show all customers" do
      get :index
      expect(response).to have_http_status :ok
    end
  end

end
