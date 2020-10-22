require 'rails_helper'

describe "Merchant Items Search" do
  it 'can get items related to one merchant' do
    merchant_1 = create(:merchant)
      merchant_1.items.create!(name: "Fries", description: "Deliciouso!", unit_price: 100.0)
      merchant_1.items.create!(name: "Ketchup", description: "It's red.", unit_price: 200.0)
      merchant_1.items.create!(name: "Mustard", description: "It's yellow.", unit_price: 300.0)
    merchant_2 = create(:merchant)
      item_2 = merchant_2.items.create!(name: "Rose", description: "red", unit_price: 400.0)

    get "/api/v1/merchants/#{merchant_1.id}/items"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(items.count).to eq(3)
    items.each do |item|
      expect(Item.find(item[:id])).to_not eq(item_2)
    end
  end
end
