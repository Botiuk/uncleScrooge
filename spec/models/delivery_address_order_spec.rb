# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DeliveryAddressOrder do
  describe 'validations' do
    it 'is valid with valid attributes' do
      delivery_address_order = build(:delivery_address_order)
      expect(delivery_address_order).to be_valid
    end

    it 'is not valid without delivery_address_id' do
      delivery_address_order = build(:delivery_address_order, delivery_address_id: nil)
      expect(delivery_address_order).not_to be_valid
    end

    it 'is not valid without order_id' do
      delivery_address_order = build(:delivery_address_order, order_id: nil)
      expect(delivery_address_order).not_to be_valid
    end
  end
end
