# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Storehouse do
  describe 'validations' do
    it 'is valid with valid attributes' do
      storehouse = build(:storehouse)
      expect(storehouse).to be_valid
    end

    it 'is not valid without a product_id' do
      storehouse = build(:storehouse, product_id: nil)
      expect(storehouse).not_to be_valid
    end

    it 'is not valid without a operation_type' do
      storehouse = build(:storehouse, operation_type: nil)
      expect(storehouse).not_to be_valid
    end

    it 'is not valid without a quantity' do
      storehouse = build(:storehouse, quantity: nil)
      expect(storehouse).not_to be_valid
    end

    it 'is not valid if quantity not number' do
      storehouse = build(:storehouse, quantity: 'five')
      expect(storehouse).not_to be_valid
    end

    it 'is not valid if quantity not integer' do
      storehouse = build(:storehouse, quantity: 1.5)
      expect(storehouse).not_to be_valid
    end

    it 'is not valid if quantity 0' do
      storehouse = build(:storehouse, quantity: 0)
      expect(storehouse).not_to be_valid
    end

    it 'is not valid if quantity negative number' do
      storehouse = build(:storehouse, quantity: -1)
      expect(storehouse).not_to be_valid
    end
  end
end
