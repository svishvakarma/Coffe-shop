class ProductsController < ApplicationController
 skip_before_action :verify_authenticity_token  

  def index
    @products = Product.all 
    render json:  @products.all.map{|product| ProductSerializer.new(product).serializable_hash }  
  end

  def show
    @product = Product.find(params[:id])
    render json: ProductSerializer.new(@product).serializable_hash, status: :ok  
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      render json: ProductSerializer.new(@product).to_json, status: :ok  
    else
      render json: {message: 'error'}
    end
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      render json: ProductSerializer.new(@product).serializable_hash, status: 200 
    else
      render json: ProductSerializer.new(@product).serializable_hash, status: :unprocessable_entity
    end
  end

  def destroy
    @product = Product.find(params[:id])
    if @product.destroy
      render json: {message: 'product deleted succesfully'}
    else 
      render json: ProductSerializer.new(@product).serializable_hash, status: :unprocessable_entity
    end
  end

  private
  
  def product_params
    params.require(:product).permit(:name,:description,:price,:tax_rate_id)
  end

end

