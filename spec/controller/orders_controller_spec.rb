require "rails_helper"
RSpec.describe OrdersController, type: :controller do
  before(:each)  do
    @tax_rate = TaxRate.create(name:"hjfd", rate:23)
    @product = Product.create(name:"jdfk", price:34, description: "kdhjfk",tax_rate_id: @tax_rate.id) 
    @customer = Customer.create(name: "df", email: "dfj@gmial.com", address: "jdhfj", pincode:343)
    @order = Order.create(customer_id: @customer.id, email: "djf@gmail.com", order_items_attributes:[{
      product_id: @product.id, quantity:3
    }])
  end 

  describe "#index" do
    it "show all customers" do
      get :index
      expect(response).to have_http_status :ok
    end
  end

  describe '#create' do
    it 'will create order' do
      params = {
        order: {
          customer_id: @customer.id,
          email: "john@gmail.com",
          order_items_attributes: [
            {
              product_id: @product.id,
              quantity: 34
            }
          ]
        }
      }

      post :create, params: params 
      expect(response).to have_http_status :created
    end
  end  

  describe "#show" do
    it 'will show a particular order ' do
      get :show, params: { id: @order.id}
      expect(response).to have_http_status(200)
    end
  end


  describe "#update " do
    it 'will update a request' do
      put :update, 
      params: {
        id: @order.id,
        "order": {
          "customer_id": @customer.id,
          "email": "john@gmail.com",
          "order_items_attributes": [
            {
              "product_id": @product.id,
              "quantity": 34
            }
          ]
        }
      }      
      expect(response).to have_http_status(200)
    end
  end

  describe "#destroy" do
    it "destroys order and returns success message" do
      delete :destroy, params: { id: @order.id }
      expect(response).to have_http_status(200)
    end
  end

end
