# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderItem do
  describe 'validations' do
    it 'is valid with valid attributes' do
      order_item = build(:order_item)
      expect(order_item).to be_valid
    end

    it 'is not valid without order_id' do
      order_item = build(:order_item, order_id: nil)
      expect(order_item).not_to be_valid
    end

    it 'is not valid without storehouse_id' do
      order_item = build(:order_item, storehouse_id: nil)
      expect(order_item).not_to be_valid
    end

    it 'is not valid without product_price' do
      order_item = build(:order_item, product_price: nil)
      expect(order_item).not_to be_valid
    end
  end
end
