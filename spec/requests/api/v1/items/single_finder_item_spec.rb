require 'rails_helper'

describe "Single Finder for item" do
  it 'can return a single record that matches a set criteria' do
    merchant_3 = Merchant.create!(name: "Goodbye Blue Monday's")
      item_3 = merchant_3.items.create!(name: "Mustard", description: "It's yellow.", unit_price: 300.0)

      search_1 = {
        name: "ustard"
      }
#can find one item
    get "/api/v1/items/find?name=ustard"
    expect(response).to be_successful
    json = JSON.parse(response.body, symbolize_names: true)
    item_a = json[:data]
    expect(json[:data][:attributes][:name]).to eq(item_3.name)
end
it 'can search by created_at' do
      merchant_1 = Merchant.create!(name: "Lasondra's Art History Museum")
        item_1 = merchant_1.items.create!(name: "Fries", description: "Deliciouso!", unit_price: 100.0, created_at: "Thu, 12 Oct 2013 13:47:38 UTC +00:00", updated_at: "Thu, 22 Oct 2014 13:47:38 UTC +00:00")

      search_2 = {
        created_at: "Thu, 12 Oct 2013 13:47:38 UTC +00:00"
      }
#can find using timestamp created_at
    get '/api/v1/items/find', params: search_2
    expect(response).to be_successful
    json = JSON.parse(response.body, symbolize_names: true)
    item_b = json[:data]
    expect(item_b[:attributes][:name]).to eq(item_1.name)
end
it 'can search by updated_at' do
        merchant_1 = Merchant.create!(name: "Lasondra's Art History Museum")
          item_1 = merchant_1.items.create!(name: "Fries", description: "Deliciouso!", unit_price: 100.0, created_at: "Thu, 12 Oct 2013 13:47:38 UTC +00:00", updated_at: "Thu, 22 Oct 2014 13:47:38 UTC +00:00")

      search_3 = {
        updated_at: "Thu, 22 Oct 2014 13:47:38 UTC +00:00"
      }
#can find using timestamp updated_at
    get '/api/v1/items/find', params: search_3
    expect(response).to be_successful
    json = JSON.parse(response.body, symbolize_names: true)
    item_c = json[:data]
    expect(item_c[:attributes][:name]).to eq(item_1.name)
  end
end
