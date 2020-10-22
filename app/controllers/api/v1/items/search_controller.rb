class Api::V1::Items::SearchController < ApplicationController

  def show
    merchant = Item.find(params[:id]).merchant
    render json: MerchantSerializer.new(merchant)
  end

end
