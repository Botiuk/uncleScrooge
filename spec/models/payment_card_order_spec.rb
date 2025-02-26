# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PaymentCardOrder do
  describe 'validations' do
    it 'is valid with valid attributes' do
      payment_card_order = build(:payment_card_order)
      expect(payment_card_order).to be_valid
    end

    it 'is not valid without payment_card_id' do
      payment_card_order = build(:payment_card_order, payment_card_id: nil)
      expect(payment_card_order).not_to be_valid
    end

    it 'is not valid without order_id' do
      payment_card_order = build(:payment_card_order, order_id: nil)
      expect(payment_card_order).not_to be_valid
    end
  end
end
