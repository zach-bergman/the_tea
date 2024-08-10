FactoryBot.define do
  factory :customer_subscription do
    association :customer
    association :subscription
    status { 1 }
  end
end