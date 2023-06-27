class CustomersController < ApplicationController
  skip_before_action :verify_authenticity_token  

  def index
    @customers = Customer.all
    render json: @customers.all.map { |customer| CustomerSerializer.new(customer).serializable_hash }
  end

  def show
    @customer = Customer.find(params[:id])
    render json: CustomerSerializer.new(@customer).serializable_hash, status: :ok  
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      render json: CustomerSerializer.new(@customer).serializable_hash, status: :created  
    else
      render json: {message: 'error'}
    end
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      render json: CustomerSerializer.new(@customer).serializable_hash, status: 200 
    else
      render json: CustomerSerializer.new(@customer).serializable_hash, status: :unprocessable_entity
    end
  end

  def destroy
    @customer = Customer.find(params[:id])
    if @customer.destroy
      render json: {message: 'customer deleted succesfully'}
    else 
      render json: CustomerSerializer.new(@customer).serializable_hash, status: :unprocessable_entity
    end
  end

  private
  
  def customer_params
    params.require(:customer).permit(:name,:email,:address,:pincode)
  end
end
