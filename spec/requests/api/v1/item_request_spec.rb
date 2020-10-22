require 'rails_helper'

describe "Items API" do
  it 'gets all items' do
    merchant_1 = create(:merchant)
      merchant_1.items.create!(name: "Fries", description: "Deliciouso!", unit_price: 100.0)
    merchant_2 = create(:merchant)
      merchant_2.items.create!(name: "Ketchup", description: "It's red.", unit_price: 200.0)

    merchant_3 = create(:merchant)
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
    merchant_1 = create(:merchant)
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

  it 'can create an item' do
    merchant_1 = create(:merchant)

    name = "Poop Emoji"
    description = "Brown poop emoji."
    unit_price = 893.45
    merchant_id = merchant_1.id

    body = {
      name: name,
      description: description,
      unit_price: unit_price,
      merchant_id: merchant_id
    }

    post "/api/v1/items", :params => body

    json = JSON.parse(response.body, symbolize_names: true)

    new_item = json[:data]

    expect(new_item[:attributes][:name]).to eq(name)
    expect(new_item[:attributes][:description]).to eq(description)
    expect(new_item[:attributes][:unit_price]).to eq(unit_price)
    expect(new_item[:attributes][:merchant_id]).to eq(merchant_id)

  end

  it "can delete item" do
    merchant_1 = create(:merchant)

    name = "Poop Emoji"
    description = "Brown poop emoji."
    unit_price = 893.45
    merchant_id = merchant_1.id

    body = {
      name: name,
      description: description,
      unit_price: unit_price,
      merchant_id: merchant_id
    }

    item = Item.create!(body)

    expect{ delete "/api/v1/items/#{item.id}" }.to change(Item, :count).by(-1)
    expect(response).to be_successful
    expect(response.status).to eq(204)
    expect(response.body).to be_empty
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it 'updates an item' do
    merchant_1 = create(:merchant)
    name = "Poop Emoji"
    description = "Brown poop emoji."
    unit_price = 893.45
    merchant_id = merchant_1.id

    body = {
      name: name,
      description: description,
      unit_price: unit_price,
      merchant_id: merchant_id
    }

    item = Item.create!(body)
    new_name = "Rainbow Poop Emoji"
    new_description = "Rainbow"

    body = {
      id: item.id,
      name: new_name,
      description: new_description
    }
    patch "/api/v1/items/#{item.id}", :params => body

    item.reload

    expect(item.name).to eq(new_name)
    expect(item.description).to eq(new_description)
  end
end
