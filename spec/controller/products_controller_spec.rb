require 'rails_helper'
RSpec.describe ProductsController, type: :controller do
let(:product) { FactoryBot.create(:product) }

  describe "#index" do
    it "show all product" do
      get :index
      expect(response).to have_http_status :ok
    end
  end

  describe '#create' do
    it 'will create product' do
      params = {
        product: {
            name: "dkf",
            price: 34,
            description: "jdhfjdddk",
        }
      }
      post :create, params: params
      expect(response).to have_http_status :created
    end
  end

  describe "#show" do
    it 'will show a particular product' do
      get :show, params: { id: product.id}
      expect(response).to have_http_status(200)
    end
  end


  describe "#update " do
    it 'will update a product' do
      put :update, params: { id: product.id, "product": { "name": "jhjdjd", "description": "liamlcom", "price": 34 }}
      expect(response).to have_http_status(200)
    end
  end

  describe "#destroy" do
    it "destroys product and returns success message" do
      delete :destroy, params: { id: product.id }
      expect(response).to have_http_status(200)
    end
  end

end
