# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DeliveryAddress do
  describe 'validations' do
    it 'is valid with valid attributes' do
      delivery_address = build(:delivery_address)
      expect(delivery_address).to be_valid
    end

    it 'is not valid without user_id' do
      delivery_address = build(:delivery_address, user_id: nil)
      expect(delivery_address).not_to be_valid
    end

    it 'is not valid without post_service' do
      delivery_address = build(:delivery_address, post_service: nil)
      expect(delivery_address).not_to be_valid
    end

    it 'is not valid without country' do
      delivery_address = build(:delivery_address, country: nil)
      expect(delivery_address).not_to be_valid
    end

    it 'is not valid without locality' do
      delivery_address = build(:delivery_address, locality: nil)
      expect(delivery_address).not_to be_valid
    end

    it 'is not valid without address' do
      delivery_address = build(:delivery_address, address: nil)
      expect(delivery_address).not_to be_valid
    end

    it 'is not valid without personal_name' do
      delivery_address = build(:delivery_address, personal_name: nil)
      expect(delivery_address).not_to be_valid
    end

    it 'is not valid without phone' do
      delivery_address = build(:delivery_address, phone: nil)
      expect(delivery_address).not_to be_valid
    end
  end
end
