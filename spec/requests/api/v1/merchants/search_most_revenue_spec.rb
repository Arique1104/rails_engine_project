# require 'rails_helper'
#
# describe "Returns all records of Merchants with most revenue" do
#   it "can return one record" do
#     merchant_1 = create(:merchant)
#     item_1 = create(:item, merchant_id: merchant_1.id, unit_price: 100.00)
#     customer_1 = create(:customer)
#     invoice_1 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer_1.id)
#     transaction_1 = create(:transaction, invoice_id: invoice_1.id)
#     invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, quantity: 4, unit_price: 100.00)
#
#     merchant_2 = create(:merchant)
#     item_2 = create(:item, merchant_id: merchant_2.id, unit_price: 100.00)
#     customer_2 = create(:customer)
#     invoice_2 = create(:invoice, merchant_id: merchant_2.id, customer_id: customer_2.id)
#     transaction_2 = create(:transaction, invoice_id: invoice_2.id)
#     invoice_item_2 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_2.id, quantity: 2, unit_price: 100.00)
#
#     merchant_3 = create(:merchant)
#     item_3 = create(:item, merchant_id: merchant_3.id, unit_price: 100.00)
#     customer_3 = create(:customer)
#     invoice_3 = create(:invoice, merchant_id: merchant_3.id, customer_id: customer_3.id)
#     transaction_3 = create(:transaction, invoice_id: invoice_3.id)
#     invoice_item_3 = create(:invoice_item, item_id: item_3.id, invoice_id: invoice_3.id, quantity: 1, unit_price: 100.00)
#
#     search = {
#       quantity: 1
#     }
#
#     get "/api/v1/merchants/most_revenue", params: search
#     expect(response).to be_successful
#     json = JSON.parse(response.body, symbolize_names: true)[:data]
#     merchant = json[:data]
#     expect(merchant.count).to eq(1)
#     expect(merchant[:attributes][:name]).to eq(merchant_1.name)
#   end
# end
