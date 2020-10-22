require 'rails_helper'

describe "Item Merchant Search" do
  it 'can get merchant related to item' do
    merchant_1 = create(:merchant)
    item_1 =  merchant_1.items.create!(name: "Fries", description: "Deliciouso!", unit_price: 100.0)

    merchant_2 = create(:merchant)
      item_2 = merchant_2.items.create!(name: "Rose", description: "red", unit_price: 400.0)

    get "/api/v1/items/#{item_1.id}/merchant"

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(Merchant.find(merchant[:id])).to_not eq(merchant_2)

  end
end
