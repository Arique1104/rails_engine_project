class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end
  def show
    render json: ItemSerializer.new(Item.find_by(item_params))
  end
  def create
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
    item = Item.create!(item_params)
    render json: ItemSerializer.new(item)
  end

  def destroy
    item = Item.find_by(item_params)
    item.destroy
    render json: {}, status: :no_content
  end

  def update
    item = Item.update(params[:id], item_params)
    render json: ItemSerializer.new(item)
  end

  private
  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end

end
