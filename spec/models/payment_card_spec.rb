# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PaymentCard do
  describe 'validations' do
    it 'is valid with valid attributes' do
      payment_card = build(:payment_card)
      expect(payment_card).to be_valid
    end

    it 'is not valid without user_id' do
      payment_card = build(:payment_card, user_id: nil)
      expect(payment_card).not_to be_valid
    end

    it 'is not valid without card_number' do
      payment_card = build(:payment_card, card_number: nil)
      expect(payment_card).not_to be_valid
    end

    it 'is not valid without expiry_month' do
      payment_card = build(:payment_card, expiry_month: nil)
      expect(payment_card).not_to be_valid
    end

    it 'is not valid without expiry_year' do
      payment_card = build(:payment_card, expiry_year: nil)
      expect(payment_card).not_to be_valid
    end

    it 'is not valid without cvv' do
      payment_card = build(:payment_card, cvv: nil)
      expect(payment_card).not_to be_valid
    end

    it 'is valid if 16 digits card_number separate with dashes or whitespaces (remove before_validation)' do
      payment_card = build(:payment_card, card_number: '1234-5678 9012-3456 ')
      expect(payment_card).to be_valid
    end

    it 'is not valid if card_number not only digit symbols' do
      payment_card = build(:payment_card, card_number: '123456789012345a')
      expect(payment_card).not_to be_valid
    end

    it 'is not valid if card_number not 16 symbols' do
      payment_card = build(:payment_card, card_number: '1234567890')
      expect(payment_card).not_to be_valid
    end

    it 'is not valid if expiry_month not only digit symbols' do
      payment_card = build(:payment_card, expiry_month: 'january')
      expect(payment_card).not_to be_valid
    end

    it 'is not valid if expiry_month less than 0' do
      payment_card = build(:payment_card, expiry_month: -2)
      expect(payment_card).not_to be_valid
    end

    it 'is not valid if expiry_month greater than 12' do
      payment_card = build(:payment_card, expiry_month: 13)
      expect(payment_card).not_to be_valid
    end

    it 'is not valid if expiry_year not only digit symbols' do
      payment_card = build(:payment_card, expiry_year: 'year')
      expect(payment_card).not_to be_valid
    end

    it 'is not valid if expiry_year less than last two digit of current' do
      payment_card = build(:payment_card, expiry_year: (Time.zone.today.year - 2001))
      expect(payment_card).not_to be_valid
    end

    it 'is not valid if expiry_year not two digit' do
      payment_card = build(:payment_card, expiry_year: Time.zone.today.year)
      expect(payment_card).not_to be_valid
    end

    it 'is not valid if card expiry ended' do
      this_year = Time.zone.today.year - 2000
      payment_card = build(:payment_card, expiry_year: this_year, expiry_month: (Time.zone.today.month - 1))
      expect(payment_card).not_to be_valid
    end

    it 'is not valid if cvv is not not only digit symbols' do
      payment_card = build(:payment_card, cvv: '12a')
      expect(payment_card).not_to be_valid
    end

    it 'is not valid if cvv is not 3 digit' do
      payment_card = build(:payment_card, cvv: 12)
      expect(payment_card).not_to be_valid
    end
  end
end
