require "rails_helper"

RSpec.describe "Api::V1::CustomerSubscriptions", type: :request do
  before :each do
    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @subscription_1 = create(:subscription)
    @subscription_2 = create(:subscription)
    @subscription_3 = create(:subscription)
    @subscription_4 = create(:subscription)
  end

  describe "POST /api/v1/customer_subscriptions" do
    it "creates a new customer_subscription record when both a customer id and subscription id is given in body of request,
    response will include subscription title, price and frequency" do
      params = { customer_id: @customer_1.id, subscription_id: @subscription_1.id }

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/customer_subscriptions", headers: headers, params: JSON.generate(params)

      expect(response).to be_successful
      expect(response.status).to eq(201)
      
      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response_body).to have_key(:data)
      expect(response_body[:data]).to have_key(:id)
      expect(response_body[:data][:id]).to be_a(String)
      expect(response_body[:data][:type]).to eq("customer_subscription")
      expect(response_body[:data][:attributes][:status]).to eq("active")
      expect(response_body[:data][:attributes][:title]).to eq(@subscription_1.title)
      expect(response_body[:data][:attributes][:price]).to eq(@subscription_1.price)
      expect(response_body[:data][:attributes][:frequency]).to eq(@subscription_1.frequency)
      expect(response_body[:data][:relationships][:customer][:data][:id]).to eq(@customer_1.id.to_s)
      expect(response_body[:data][:relationships][:subscription][:data][:id]).to eq(@subscription_1.id.to_s)

      created_customer_subscription = CustomerSubscription.last

      expect(created_customer_subscription.customer).to eq(@customer_1)
      expect(created_customer_subscription.subscription).to eq(@subscription_1)
      expect(created_customer_subscription.status).to eq("active")
    end

    describe "sad paths" do
      it "returns correct error if customer_id is missing" do
        params = { subscription_id: @subscription_1.id }

        headers = {"CONTENT_TYPE" => "application/json"}
  
        post "/api/v1/customer_subscriptions", headers: headers, params: JSON.generate(params)

        expect(response).to_not be_successful
        expect(response.status).to eq(422)

        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response_body).to be_a(Hash)
        expect(response_body).to have_key(:errors)
        expect(response_body[:errors]).to be_a(Array)
        expect(response_body[:errors].first[:status]).to eq(422)
        expect(response_body[:errors].first[:message]).to eq("Validation failed: Customer must exist, Customer can't be blank")
      end

      it "returns correct error if subscription_id is missing" do
        params = { customer_id: @customer_1.id}

        headers = {"CONTENT_TYPE" => "application/json"}
  
        post "/api/v1/customer_subscriptions", headers: headers, params: JSON.generate(params)

        expect(response).to_not be_successful
        expect(response.status).to eq(422)

        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response_body).to be_a(Hash)
        expect(response_body).to have_key(:errors)
        expect(response_body[:errors]).to be_a(Array)
        expect(response_body[:errors].first[:status]).to eq(422)
        expect(response_body[:errors].first[:message]).to eq("Validation failed: Subscription must exist, Subscription can't be blank")
      end

      it "returns correct error if customer_id is not valid" do
        params = { customer_id: 999, subscription_id: @subscription_1.id }

        headers = {"CONTENT_TYPE" => "application/json"}
  
        post "/api/v1/customer_subscriptions", headers: headers, params: JSON.generate(params)

        expect(response).to_not be_successful
        expect(response.status).to eq(422)

        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response_body).to be_a(Hash)
        expect(response_body).to have_key(:errors)
        expect(response_body[:errors]).to be_a(Array)
        expect(response_body[:errors].first[:status]).to eq(422)
        expect(response_body[:errors].first[:message]).to eq("Validation failed: Customer must exist")
      end

      it "returns correct error if subscription_id is not valid" do
        params = { customer_id: @customer_1.id, subscription_id: 999 }

        headers = {"CONTENT_TYPE" => "application/json"}
  
        post "/api/v1/customer_subscriptions", headers: headers, params: JSON.generate(params)

        expect(response).to_not be_successful
        expect(response.status).to eq(422)

        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response_body).to be_a(Hash)
        expect(response_body).to have_key(:errors)
        expect(response_body[:errors]).to be_a(Array)
        expect(response_body[:errors].first[:status]).to eq(422)
        expect(response_body[:errors].first[:message]).to eq("Validation failed: Subscription must exist")
      end
    end
  end
end