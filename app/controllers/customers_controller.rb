class CustomersController < ApplicationController
  skip_before_action :verify_authenticity_token  

  def index
    @customers = Customer.all
    render json: @customers
  end

  def show
   @customer = Customer.find(params[:id])
   render json: @customer 
  end

  def create
   @customer = Customer.new(customer_params)
    if @customer.save
     render json: {message: @customer}
    else
    render json: {message: 'error'}
   end
  end

  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy
    render json: {message: 'deleted succesfully'}
  end

  private
  
  def customer_params
    params.permit(:name,:email,:address,:pincode)
  end

end
