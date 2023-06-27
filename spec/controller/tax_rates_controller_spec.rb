require 'rails_helper'
RSpec.describe TaxRatesController, type: :controller do

  let(:tax_rate) { FactoryBot.create(:tax_rate) }

  describe "#index" do
    it "show all customers" do
      get :index
      expect(response).to have_http_status :ok
    end
  end


  describe '#create' do
    it 'will create tax rate' do
      params = {
        name: "John Doe",
        rate: "jmaicom",
      }
      post :create, params: params
      expect(response).to have_http_status :created
    end
  end

  describe "#show" do
    it 'will show a particular tax_rate' do
      get :show, params: { id: tax_rate.id}
      expect(response).to have_http_status(200)
    end
  end


  describe "#update " do
    it 'will update a rate' do
      put :update, params: { id: tax_rate.id, name: "jhjdjd", rate: 4 }
      expect(response).to have_http_status(200)
    end
  end

  describe "#destroy" do
    it "destroys rate and returns success message" do
      delete :destroy, params: { id: tax_rate.id }
      expect(response).to have_http_status(200)
    end
  end


end
