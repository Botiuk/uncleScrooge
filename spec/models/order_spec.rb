# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order do
  describe 'validations' do
    it 'is valid with valid attributes' do
      order = build(:order)
      expect(order).to be_valid
    end

    it 'is not valid without cart_id' do
      order = build(:order, cart_id: nil)
      expect(order).not_to be_valid
    end

    it 'is not valid without order_price' do
      order = build(:order, order_price: nil)
      expect(order).not_to be_valid
    end
  end

  describe 'order_status' do
    it 'order_status does not set in factory' do
      order = build(:order)
      expect(order.order_status).to eq('active')
    end

    it 'order_status put on create' do
      order = build(:order, order_status: 'complecting')
      expect(order.order_status).to eq('complecting')
    end

    it 'order_status put on change' do
      order = create(:order)
      order.order_status = 'sended'
      order.save
      expect(order.order_status).to eq('sended')
    end
  end
end
