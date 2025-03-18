# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Discount do
  describe 'validations' do
    it 'is valid with valid attributes' do
      discount = build(:discount)
      expect(discount).to be_valid
    end

    it 'is not valid without user_id' do
      discount = build(:discount, user_id: nil)
      expect(discount).not_to be_valid
    end

    it 'is not valid if persentage not integer' do
      discount = build(:discount, percentage: 5.0)
      expect(discount).not_to be_valid
    end

    it 'is not valid if persentage not number' do
      discount = build(:discount, percentage: 'five')
      expect(discount).not_to be_valid
    end

    it 'is not valid if persentage not positive integer' do
      discount = build(:discount, percentage: -5)
      expect(discount).not_to be_valid
    end

    it 'is not valid if persentage grater than 100' do
      discount = build(:discount, percentage: 101)
      expect(discount).not_to be_valid
    end

    it 'is not valid if spent_money not number' do
      discount = build(:discount, spent_money: 'five thousand')
      expect(discount).not_to be_valid
    end

    it 'is not valid if spent_money not positive number' do
      discount = build(:discount, spent_money: -500.01)
      expect(discount).not_to be_valid
    end

    it 'is valid if spent_money integer' do
      discount = build(:discount, spent_money: 500)
      expect(discount).to be_valid
    end
  end
end
