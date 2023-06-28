require 'rails_helper'
RSpec.describe DiscountsController, type: :controller do
  before(:each)  do
    @tax_rate = TaxRate.create(name:"hjfd", rate:23)
    @product = Product.create(name:"jdfk", price:34, description: "kdhjfk",tax_rate_id: @tax_rate.id) 
    @customer = Customer.create(name: "df", email: "dfj@gmial.com", address: "jdhfj", pincode:343)
    @order = Order.create(customer_id: @customer.id, email: "djf@gmail.com", order_items_attributes:[{
      product_id: @product.id, quantity:3
    }])
    @discount = Discount.create(order_id: @order.id, total_price:434,total_quantity:34, percentage:3)  
  end 

  describe "#index" do
    it "show all discount" do
      get :index
      expect(response).to have_http_status :ok
    end
  end

  describe '#create' do
    it 'will create discount' do
      params = {
        order_id: @order.id,
        total_price: 203445,
        total_quantity: 45,
        percentage: 5
      }
      post :create, params: params
      expect(response).to have_http_status :created
    end
  end

  describe "#show" do
    it 'will show a particular discount' do
      get :show, params: { id: @discount.id}
      expect(response).to have_http_status(200)
    end
  end

  describe "#update " do
    it 'will update a request' do
      put :update, params: { id: @discount.id, "order_id": @order.id, "total_price": 203445, "total_quantity": 45,"percentage": 5 }
      expect(response).to have_http_status(200)
    end
  end

  describe "#destroy" do
    it "destroys discount and returns success message" do
      delete :destroy, params: { id: @discount.id }
      expect(response).to have_http_status(200)
    end
  end

end
