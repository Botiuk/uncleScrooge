# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CartStorehouse do
  describe 'validations' do
    it 'is valid with valid attributes' do
      cart_storehouse = build(:cart_storehouse)
      expect(cart_storehouse).to be_valid
    end

    it 'is not valid without cart_id' do
      cart_storehouse = build(:cart_storehouse, cart_id: nil)
      expect(cart_storehouse).not_to be_valid
    end

    it 'is not valid without storehouse_id' do
      cart_storehouse = build(:cart_storehouse, storehouse_id: nil)
      expect(cart_storehouse).not_to be_valid
    end
  end
end
