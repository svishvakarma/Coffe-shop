require 'rails_helper'
RSpec.describe PaymentsController, type: :controller do
  before(:each)  do
    @tax_rate = TaxRate.create(name:"hjfd", rate:23)
    @product = Product.create(name:"jdfk", price:34, description: "kdhjfk",tax_rate_id: @tax_rate.id) 
    @customer = Customer.create(name: "df", email: "dfj@gmial.com", address: "jdhfj", pincode:343)
    @order = Order.create(customer_id: @customer.id, email: "djf@gmail.com", order_items_attributes:[{ product_id: @product.id, quantity:3}])
    @discount = Discount.create(order_id: @order.id, total_price:434,total_quantity:34, percentage:3)  
    @payment = Payment.create(order_id: @order.id, make_payment: 232, email: "dj@gmail.com")
  end 

  describe "#index" do
    it "show all payments" do
      get :index
      expect(response).to have_http_status :ok
    end
  end

  describe '#create' do
    it 'will create payment' do
      params = {
		  	order_id: @order.id,
				make_payment: 43,
				email: "john@gmail.com",
			}
      post :create, params: params
      expect(response).to have_http_status :ok  
    end
  end

  describe "#show" do
    it 'will show a particular payment' do
      get :show, params: { id: @payment.id}
      expect(response).to have_http_status(200)
    end
  end

  describe "#update " do
    it 'will update a request' do
      put :update, params: { id: @payment.id, "order_id": @order.id,  "make_payment": 45,"email": "john@gmail.com" }
      expect(response).to have_http_status(200)
    end
  end  

  describe "#destroy" do
    it "destroys payment and returns success message" do
      delete :destroy, params: { id: @payment.id }
      expect(response).to have_http_status(200)
    end
  end

end
