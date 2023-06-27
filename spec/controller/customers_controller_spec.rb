require 'rails_helper'
RSpec.describe CustomersController, type: :controller do
  let(:customer) { FactoryBot.create(:customer) }

  describe "#index" do
    it "show all customers" do
      get :index
      expect(response).to have_http_status :ok
    end
  end

  describe '#create' do
    it 'will create customer' do
      params = {
        customer: {
            name: "John Doe",
            email: "john@gmail.com",
            address: "jdhfjdddk",
            pincode: 734834
        }
      }
      post :create, params: params
      expect(response).to have_http_status :created
    end
  end

  describe "#show" do
    it 'will show a particular customer' do
      get :show, params: { id: customer.id}
      expect(response).to have_http_status(200)
    end
  end

  describe "#update " do
    it 'will update a request' do
      put :update, params: { id: customer.id, "customer": { "name": "jhjdjd", "email": "liam@gmail.com", "address": "kdjkkd", "pincode":3878 }}
      expect(response).to have_http_status(200)
    end
  end

  describe "#destroy" do
    it "destroys customers and returns success message" do
      delete :destroy, params: { id: customer.id }
      expect(response).to have_http_status(200)
    end
  end

end
