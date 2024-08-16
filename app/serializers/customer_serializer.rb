class CustomerSerializer
  include JSONAPI::Serializer
  
  attributes :first_name, :last_name, :email, :address

  has_many :customer_subscriptions
  has_many :subscriptions, through: :customer_subscriptions
end