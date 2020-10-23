class Api::V1::Merchants::SearchController < ApplicationController

  def show
    merchant = Merchant.find(params[:id])
    render json: ItemSerializer.new(merchant.items)
  end

  def find
    attribute = params.keys[0]
    query = params[attribute]
    @merchant = format(attribute, query).first
    render json: MerchantSerializer.new(@merchant)
  end

  def find_all
    attribute = params.keys[0]
    query = params[attribute]
    @merchants = format(attribute, query)
    render json: MerchantSerializer.new(@merchants)
  end

  private
  def format(attribute, query)
    if attribute == "created_at"
      time_format(attribute, query)
    elsif attribute == "updated_at"
      time_format(attribute, query)
    else
      Merchant.where("lower(#{attribute}) LIKE lower(?)", "%#{query}%")
    end
  end

  def time_format(attribute, query)
    time = Date.parse(query)
    Merchant.where("#{attribute} > ?", "#{time.beginning_of_day}")
  end

end
