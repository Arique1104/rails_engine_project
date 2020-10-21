class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end
  def show
    render json: ItemSerializer.new(Item.find_by(item_params))
  end

  private
  def item_params
    params.permit(:id)
  end

end
