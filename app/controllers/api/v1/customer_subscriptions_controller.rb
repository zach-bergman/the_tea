class Api::V1::CustomerSubscriptionsController < ApplicationController
  def index
    customer = Customer.find(params[:customer_id])

    if params[:status] == 'active'
      render json: CustomerSubscriptionSerializer.new(customer.customer_subscriptions.active), status: 200
    elsif params[:status] == 'cancelled'
      render json: CustomerSubscriptionSerializer.new(customer.customer_subscriptions.cancelled), status: 200
    else
      render json: CustomerSubscriptionSerializer.new(customer.customer_subscriptions), status: 200
    end
  end

  def create
    customer_subscription = CustomerSubscription.new(customer_subscription_params)
    customer_subscription.save!

    render json: CustomerSubscriptionSerializer.new(customer_subscription), status: 201
  end

  def update
    customer_subscription = CustomerSubscription.find(params[:id])
    customer_subscription.update!(status: params[:status])

    render json: CustomerSubscriptionSerializer.new(customer_subscription), status: 200
  end

  private

  def customer_subscription_params
    params.permit(:customer_id, :subscription_id)
  end
end