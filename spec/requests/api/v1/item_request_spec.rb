require 'rails_helper'

describe "Items API" do
  it 'gets all items' do
    merchant_1 = create_list(:merchant, 1)[0]
      merchant_1.items.create!(name: "Fries", description: "Deliciouso!", unit_price: 100.0)
    merchant_2 = create_list(:merchant, 1)[0]
      merchant_2.items.create!(name: "Ketchup", description: "It's red.", unit_price: 200.0)

    merchant_3 = create_list(:merchant, 1)[0]
      merchant_3.items.create!(name: "Mustard", description: "It's yellow.", unit_price: 300.0)

      get '/api/v1/items'
      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(items.count).to eq(3)
      items.each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_a(String)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)

        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_a(String)

        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)

        expect(item[:attributes]).to have_key(:merchant_id)
        expect(item[:attributes][:merchant_id]).to be_a(Integer)
      end
    end

    it "can get one item" do
      merchant_1 = create_list(:merchant, 1)[0]
      item = Item.create!(name: "Fries", description: "Deliciouso!", unit_price: 100.0, merchant_id: merchant_1.id )

      get "/api/v1/items/#{item.id}"
      expect(response).to be_successful

      item = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_a(Integer)

  end
end
