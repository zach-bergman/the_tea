class Api::V1::CustomerSubscriptionsController < ApplicationController
  def create
    customer_subscription = CustomerSubscription.new(customer_subscription_params)
    customer_subscription.save!
    
    render json: CustomerSubscriptionSerializer.new(customer_subscription), status: 201
  end

  private

  def customer_subscription_params
    params.permit(:customer_id, :subscription_id)
  end
end