FactoryBot.define do
  factory :subscription do
    title { Faker::Commerce.product_name }
    price { Faker::Number.between(from: 1, to: 500) }
    status { Faker::Number.between(from: 0, to: 1) }
    frequency { Faker::Number.between(from: 1, to: 6) }
  end
end