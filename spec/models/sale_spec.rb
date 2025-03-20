# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Sale do
  describe 'validations' do
    it 'is valid with valid attributes' do
      sale = build(:sale)
      expect(sale).to be_valid
    end

    it 'is not valid without product_id' do
      sale = build(:sale, product_id: nil)
      expect(sale).not_to be_valid
    end

    it 'is not valid without percentage' do
      sale = build(:sale, percentage: nil)
      expect(sale).not_to be_valid
    end

    it 'is not valid without start_date' do
      sale = build(:sale, start_date: nil)
      expect(sale).not_to be_valid
    end

    it 'is not valid without end_date' do
      sale = build(:sale, end_date: nil)
      expect(sale).not_to be_valid
    end

    it 'is not valid if percentage not integer' do
      sale = build(:sale, percentage: 20.0)
      expect(sale).not_to be_valid
    end

    it 'is not valid if percentage not number' do
      sale = build(:sale, percentage: 'twenty')
      expect(sale).not_to be_valid
    end

    it 'is not valid if percentage smaler than 15' do
      sale = build(:sale, percentage: 14)
      expect(sale).not_to be_valid
    end

    it 'is not valid if percentage grater than 50' do
      sale = build(:sale, percentage: 51)
      expect(sale).not_to be_valid
    end

    it 'is not valid if start_date grather than end_date' do
      date = Time.zone.today
      sale = build(:sale, start_date: (date + 2.days), end_date: date)
      expect(sale).not_to be_valid
    end

    it 'is not valid if start_date equal to end_date' do
      date = Time.zone.today
      sale = build(:sale, start_date: date, end_date: date)
      expect(sale).not_to be_valid
    end
  end
end
