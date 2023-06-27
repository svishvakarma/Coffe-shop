class DiscountsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :get_discount, only: [:create, :update]
  before_action :find_rate, only: [:create, :update]

  def index
   discounts = Discount.all
   render json: discounts.map { |discount| DiscountSerializer.new(discount).serializable_hash }, status: :ok
  end

  def show
   discount = Discount.find(params[:id])
   render json: DiscountSerializer.new(discount).serializable_hash, status: :ok
  end

  def create
   order = Order.find(params['order_id'])
   discount = Discount.new(discount_params)
   discount.total_amount = params[:total_price] - @discounted_price
    if discount.save
     render json: DiscountSerializer.new(discount).serializable_hash, status: :ok
    else
     render json: { message: 'error' }, status: :unprocessable_entity
    end
  end

  def update
   discount = Discount.find(params[:id])
     if discount.update(discount_params)
      discount.total_amount = discounted_price
      render json: DiscountSerializer.new(discount).serializable_hash, status: :ok
    else
      render json: OrderSerializer.new(discount).serializable_hash, status: :unprocessable_entity
    end
  end

  def destroy
   discount = Discount.find(params[:id])
    if discount.destroy
     render json: { message: 'Discount deleted successfully' }, status: :ok
    else
     render json: DiscountSerializer.new(discount).serializable_hash, status: :unprocessable_entity
    end
  end

  private

  def discount_params
    params.require(:discount).permit(:total_quantity,:total_price,:order_id,:order_items_id, :percentage)
  end 
  
  def get_discount
    if params[:total_quantity] != 1
      @discounted_price = params[:total_price] * params[:percentage] / 100
    else
      render json: { message: 'error' }, status: :unprocessable_entity
    end
  end

  def find_rate
   order = Order.find(params['order_id'])
   order_items_first = order.order_items.first
   product = Product.find(order_items_first[:product_id])
   tax_rate = TaxRate.find(product.tax_rate_id)
   @tax = tax_rate.rate
  end
 
end
