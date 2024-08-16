class AddDefaultValueToCustomerSubscriptionStatus < ActiveRecord::Migration[7.1]
  def change
    change_column_default :customer_subscriptions, :status, 1
  end
end
