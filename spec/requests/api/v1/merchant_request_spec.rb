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
      expect(merchant[:id]).to be_a(String)
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)

      expect(merchant[:attributes]).to have_key(:created_at)
      expect(merchant[:attributes][:created_at]).to be_a(String)

      expect(merchant[:attributes]).to have_key(:updated_at)
      expect(merchant[:attributes][:updated_at]).to be_a(String)
    end
  end
  it 'shows a merchant' do
    merchant = create(:merchant)
    get "/api/v1/merchants/#{merchant.id}"
    expect(response).to be_successful
    merchant = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to be_an(String)

    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:attributes][:name]).to be_a(String)

    expect(merchant[:attributes]).to have_key(:created_at)
    expect(merchant[:attributes][:created_at]).to be_a(String)

    expect(merchant[:attributes]).to have_key(:updated_at)
    expect(merchant[:attributes][:updated_at]).to be_a(String)
  end

  it 'creates a merchant' do
    name = "Addams Family Orchard"
    post "/api/v1/merchants", :params => { name: "#{name}" }

    json = JSON.parse(response.body, symbolize_names: true)
    new_merchant = json[:data]
    expect(new_merchant[:attributes][:name]).to eq(name)
  end

  # it 'sends an error when not given the right information for merchant' do
  #   name = "Addams Family Orchard"
  #   get "/api/v1/merchants", :params => { name: "#{name}" }
  #   # require "pry"; binding.pry
  #   expect(response).to be_successful
  #   json = JSON.parse(response.body, symbolize_names: true)
  #   new_merchant = json[:data]
  #   expect(new_merchant).to eq("status: 404")
  # end

  it 'deletes a merchant' do
    merchant_a = create(:merchant)

    new_merchant = Merchant.create!(name: "Lasondra's Art History Center: Austin Park")

    delete "/api/v1/merchants/#{new_merchant.id}", :params => {name: "#{new_merchant.name}"}

    expect(Merchant.find_by(:id => new_merchant.id)).to be_nil
    
    expect{Merchant.find(new_merchant.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it 'updates a merchant' do
    merchant = Merchant.create!(name: "Addams Family Orchard")
    expect(merchant.name).to eq("Addams Family Orchard")

    new_name = "Ortiz Family Orchard"

    patch "/api/v1/merchants/#{merchant.id}", :params => {name: new_name}

    merchant.reload

    expect(merchant.name).to eq(new_name)
  end
end
