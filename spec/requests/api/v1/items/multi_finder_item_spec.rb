require 'rails_helper'

describe "Multi finder for item" do
  it "can return multiple records that matches a set criteria" do
  merchant_1 = Merchant.create!(name: "Goodbye Blue Monday's")
    item_1 = merchant_1.items.create!(name: "Mustard", description: "It's yellow.", unit_price: 300.0, created_at: "Thu, 12 Oct 2013 13:47:38 UTC +00:00", updated_at: "Thu, 22 Oct 2014 13:47:38 UTC +00:00")

  merchant_2 = Merchant.create!(name: "Lasondra's Art History Museum")
    item_2 = merchant_2.items.create!(name: "Custard", description: "Deliciouso!", unit_price: 100.0, created_at: "Thu, 12 Oct 2013 13:47:38 UTC +00:00", updated_at: "Thu, 22 Oct 2014 13:47:38 UTC +00:00")

    search_1 = {
      name: "ustard"
                }

    get "/api/v1/items/find_all", params: search_1
    expect(response).to be_successful
    json = JSON.parse(response.body, symbolize_names: true)
    items = json[:data]
    expect(items.count).to eq(2)
  end
  it "can search multiple items by created_at" do
    merchant_1 = Merchant.create!(name: "Goodbye Blue Monday's")
      item_1 = merchant_1.items.create!(name: "Mustard", description: "It's yellow.", unit_price: 300.0, created_at: "Thu, 12 Oct 2013 13:47:38 UTC +00:00", updated_at: "Thu, 22 Oct 2014 13:47:38 UTC +00:00")

    merchant_2 = Merchant.create!(name: "Lasondra's Art History Museum")
      item_2 = merchant_2.items.create!(name: "Custard", description: "Deliciouso!", unit_price: 100.0, created_at: "Thu, 12 Oct 2013 13:47:38 UTC +00:00", updated_at: "Thu, 22 Oct 2014 13:47:38 UTC +00:00")

    search_2 = {
      created_at: "Thu, 12 Oct 2013 13:47:38 UTC +00:00"
    }

    get "/api/v1/items/find_all", params: search_2
    expect(response).to be_successful
    json = JSON.parse(response.body, symbolize_names: true)
    items = json[:data]
    expect(items.count).to eq(2)

  end
  it "can search multiple items by updated_at" do
    merchant_1 = Merchant.create!(name: "Goodbye Blue Monday's")
      item_1 = merchant_1.items.create!(name: "Mustard", description: "It's yellow.", unit_price: 300.0, created_at: "Thu, 12 Oct 2013 13:47:38 UTC +00:00", updated_at: "Thu, 22 Oct 2014 13:47:38 UTC +00:00")

    merchant_2 = Merchant.create!(name: "Lasondra's Art History Museum")
      item_2 = merchant_2.items.create!(name: "Custard", description: "Deliciouso!", unit_price: 100.0, created_at: "Thu, 12 Oct 2013 13:47:38 UTC +00:00", updated_at: "Thu, 22 Oct 2014 13:47:38 UTC +00:00")

    search_3 = {
      updated_at: "Thu, 22 Oct 2014 13:47:38 UTC +00:00"
    }

    get "/api/v1/items/find_all", params: search_3
    expect(response).to be_successful
    json = JSON.parse(response.body, symbolize_names: true)
    items = json[:data]
    expect(items.count).to eq(2)
  end


end
