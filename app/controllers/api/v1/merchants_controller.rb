class Api::V1::MerchantsController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end

  def create
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
    Merchant.create!(merchant_params)
    render json: MerchantSerializer.new(Merchant.last)
  end

  def destroy
    merchant = Merchant.find_by(destroy_params)
    merchant.destroy
    render json: {}, status: :no_content
  end

private
  def merchant_params
    params.permit(:name)
  end

  def destroy_params
    params.permit(:id)
  end
end
