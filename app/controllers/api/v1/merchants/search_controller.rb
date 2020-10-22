class Api::V1::Merchants::SearchController < ApplicationController

  def show
    merchant = Merchant.find(params[:id])
    render json: ItemSerializer.new(merchant.items)
  end

end
