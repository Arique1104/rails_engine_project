class Api::V1::Items::SearchController < ApplicationController

  def show
    merchant = Item.find(params[:id]).merchant
    render json: MerchantSerializer.new(merchant)
  end

  def find
    attribute = params.keys[0]
    query = params[attribute]
    @item = format(attribute, query)

    render json: ItemSerializer.new(@item)
  end

  private
  def format(attribute, query)
    if attribute == "created_at"
      time_format(attribute, query)
    elsif attribute == "updated_at"
      time_format(attribute, query)
    else
      @item = Item.where("lower(#{attribute}) LIKE lower(?)", "%#{query}%").first
    end
  end

  def time_format(attribute, query)
    time = Date.parse(query)
    @item = Item.where("#{attribute} > ?", "#{time.beginning_of_day}").first
  end

end
