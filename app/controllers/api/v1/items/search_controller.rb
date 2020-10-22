class Api::V1::Items::SearchController < ApplicationController

  def show
    merchant = Item.find(params[:id]).merchant
    render json: MerchantSerializer.new(merchant)
  end

  def find
    attribute = params.keys[0]
    query = params[attribute]

    if attribute == "created_at"
      time = Date.parse(query)
      @item = Item.where("#{attribute} > ?", "#{time.beginning_of_day}").limit(1)
    elsif attribute == "updated_at"
      time = Date.parse(query)
      @item = Item.where("#{attribute} > ?", "#{time.beginning_of_day}").limit(1)
    else
      @item = Item.where("lower(#{attribute}) LIKE lower(?)", "%#{query}%").first
    end
    render json: ItemSerializer.new(@item)
  end

end
