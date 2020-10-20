require 'rails_helper'

describe "Merchants API" do
  it 'gets merchants' do
    create_list(:merchant, 3)
    get '/api/v1/merchants'
    expect(response).to be_successful
    merchants = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(merchants.count).to eq(3)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(String)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)

      expect(merchant[:attributes]).to have_key(:created_at)
      expect(merchant[:attributes][:created_at]).to be_a(String)

      expect(merchant[:attributes]).to have_key(:updated_at)
      expect(merchant[:attributes][:updated_at]).to be_a(String)
    end
  end
  it 'shows a merchant' do
    merchant = create_list(:merchant, 1)
    get "/api/v1/merchants/#{merchant.first.id}"
    expect(response).to be_successful
    merchant = JSON.parse(response.body, symbolize_names: true)
  end

  it 'creates a merchant' do
    name = "Addams Family Orchard"

    post "/api/v1/merchants", :params => { name: "Addams Family Orchard"}
#maybe useful for items?!
    # post "/api/v1/merchants", :params => {:merchant => { name: "Addams Family Orchard"}}

    json = JSON.parse(response.body, symbolize_names: true)
    new_merchant = json[:data]
    expect(new_merchant[:attributes][:name]).to eq(name)
  end

  it 'deletes a merchant' do
    merchant_a = create_list(:merchant, 1)

    new_merchant = Merchant.create!(name: "Lasondra's Art History Center: Austin Park")

    delete "/api/v1/merchants/#{new_merchant.id}", :params => {name: "#{new_merchant.name}"}
    get '/api/v1/merchants'
    expect(response).to be_successful
    merchants = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(merchants.count).to eq(1)

  end
end