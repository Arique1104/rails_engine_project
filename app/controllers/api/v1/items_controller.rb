class Api::V1::ItemsController < ApplicationController
  def index
    test = render json: ItemSerializer.new(Item.all)
  end
  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end
  def create
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
    item = Item.create!(item_params)
    render json: ItemSerializer.new(item)
  end

  def destroy
    Item.destroy(params[:id])
    render json: {}, status: :no_content
    # render body: nil, status: :no_content
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
