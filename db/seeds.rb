require 'CSV'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Merchant.destroy_all
Customer.destroy_all
Item.destroy_all
Invoice.destroy_all
Transaction.destroy_all

CSV.foreach(Rails.root.join('db/data/merchants.csv'), headers: true) do |row|
  # row["name"] = row["name"].to_i
  hashed_row = row.to_h
  Merchant.create!(name: hashed_row["name"], created_at: hashed_row["created_at"], updated_at: hashed_row["updated_at"])
end

CSV.foreach(Rails.root.join('db/data/customers.csv'), headers: true) do |row|
  hashed_row = row.to_h
  Customer.create!(first_name: hashed_row["first_name"], last_name: hashed_row["last_name"], created_at: hashed_row["created_at"], updated_at: hashed_row["updated_at"])
end

CSV.foreach(Rails.root.join('db/data/items.csv'), headers: true) do |row|
  hashed_row = row.to_h
  unit_price = (hashed_row["unit_price"].to_i / 100).to_f.round(2)
  Item.create!(name: hashed_row["name"], description: hashed_row["description"], unit_price: unit_price, merchant_id: hashed_row["merchant_id"], created_at: hashed_row["created_at"], updated_at: hashed_row["updated_at"])
end

CSV.foreach(Rails.root.join('db/data/invoices.csv'), headers:true) do |row|
  hashed_row = row.to_h
  Invoice.create!(status: hashed_row["status"], customer_id: hashed_row["customer_id"], merchant_id: hashed_row["merchant_id"], created_at: hashed_row["created_at"], updated_at: hashed_row["updated_at"])
end

CSV.foreach(Rails.root.join('db/data/transactions.csv'), headers: true) do |row|
  hashed_row = row.to_h
  Transaction.create!(credit_card_number: hashed_row["credit_card_number"], result: hashed_row["result"], created_at: hashed_row["created_at"], updated_at: hashed_row["updated_at"], invoice_id: hashed_row["invoice_id"])
end
