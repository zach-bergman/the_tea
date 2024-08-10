class Subscription < ApplicationRecord
  has_many :customer_subscriptions
  has_many :customers, through: :customer_subscriptions

  validates :title, presence: true
  validates :price, presence: true
  validates :frequency, presence: true

  enum status: [:canceled, :active]
end