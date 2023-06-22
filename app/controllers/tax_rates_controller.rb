class TaxRatesController < ApplicationController
  skip_before_action :verify_authenticity_token  

  def index
    @tax_rates = TaxRate.all
    render json: @tax_rates.all.map { |rate| CustomerSerializer.new(rate).serializable_hash }
  end

  def show
    @tax_rate = TaxRate.find(params[:id])
    render json: TaxRateSerializer.new(@tax_rate).serializable_hash, status: :ok  
  end

  def create
    @tax_rate = TaxRate.new(tax_rate_params)
    if @tax_rate.save
      render json: TaxRateSerializer.new(@tax_rate).serializable_hash, status: :ok  
    else
      render json: {message: 'error'}
    end
  end

  def update
    @tax_rate = TaxRate.find(params[:id])
    if @tax_rate.update(tax_rate_params)
      render json: TaxRateSerializer.new(@tax_rate).serializable_hash, status: 200 
    else
      render json: TaxRateSerializer.new(@tax_rate).serializable_hash, status: :unprocessable_entity
    end
  end

  def destroy
    @tax_rate = TaxRate.find(params[:id])
    if @tax_rate.destroy
      render json: {message: 'tax rate deleted succesfully'}
    else 
      render json: TaxRateSerializer.new(@tax_rate).serializable_hash, status: :unprocessable_entity
    end
  end

  private
  
  def tax_rate_params
    params.permit(:name,:rate)
  end

end
