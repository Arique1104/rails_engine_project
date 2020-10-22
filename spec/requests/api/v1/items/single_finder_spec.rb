require 'rails_helper'

describe "Single Finder for item" do
  it 'can return a single record that matches a set criteria' do
    merchant_1 = Merchant.create!(name: "Lasondra's Art History Museum")
      item_1 = merchant_1.items.create!(name: "Fries", description: "Deliciouso!", unit_price: 100.0, created_at: "Thu, 12 Oct 2013 13:47:38 UTC +00:00", updated_at: "Thu, 22 Oct 2014 13:47:38 UTC +00:00")

    merchant_2 = Merchant.create!(name: "Addams Family Orchard")
      item_2 = merchant_2.items.create!(name: "Ketchup", description: "It's red.", unit_price: 200.0)

    merchant_3 = Merchant.create!(name: "Goodbye Blue Monday's")
      item_3 = merchant_3.items.create!(name: "Mustard", description: "It's yellow.", unit_price: 300.0)

      search_1 = {
        name: "Must"
      }

    get "/api/v1/items/find?#{search_1}"

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)

    item = json[:data]

    require "pry"; binding.pry
    #write more expectations once we hit this pry
  end
end
