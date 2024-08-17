require 'rails_helper'

RSpec.describe CustomerSubscription, type: :model do
  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should belong_to(:subscription) }
  end

  describe 'validations' do
    it { should validate_presence_of(:customer_id) }
    it { should validate_presence_of(:subscription_id) }
    it { should validate_presence_of(:status) }
  end

  describe 'enums' do
    it { should define_enum_for(:status).with_values([:cancelled, :active]) }
  end
end