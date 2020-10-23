FactoryBot.define do
  factory :transaction do
    credit_card_number { Faker::Finance.credit_card(:visa) }
    result { "success" }
    invoice_id { Faker::Number.within(range: 1..10000) }
    invoice
  end
end
