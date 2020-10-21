FactoryBot.define do
  factory :customer do
    first_name { Faker::NameDE.first_name }
    last_name { Faker::NameDE.last_name }
  end
end
