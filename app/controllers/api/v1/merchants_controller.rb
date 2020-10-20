class Api::V1::MerchantsController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end

  def create
    new_merchant = Merchant.create!(merchant_params)
    render json: MerchantSerializer.new(new_merchant)
  end

  def destroy
    merchant = Merchant.find(merchant_params[:id])
    merchant.destroy
  end

private
  def merchant_params
    params.permit(:name, :id)
  end
end
