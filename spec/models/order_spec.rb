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

    it 'is valid without message' do
      order = build(:order, message: nil)
      expect(order).to be_valid
    end

    it 'is valid without notation' do
      order = build(:order, notation: nil)
      expect(order).to be_valid
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

  describe 'phone_call' do
    it 'phone_call does not set in factory' do
      order = build(:order)
      expect(order.phone_call).to eq('not_need')
    end

    it 'phone_call put on create' do
      order = build(:order, phone_call: 'please_call')
      expect(order.phone_call).to eq('please_call')
    end
  end

  describe 'phone_call_status' do
    it 'phone_call_status does not set in factory' do
      order = build(:order)
      expect(order.phone_call_status).to eq('not_avaliable')
    end

    it 'phone_call_status put on create' do
      order = build(:order, phone_call_status: 'wait')
      expect(order.phone_call_status).to eq('wait')
    end

    it 'phone_call_status put on change' do
      order = create(:order)
      order.phone_call_status = 'did_call'
      order.save
      expect(order.phone_call_status).to eq('did_call')
    end
  end
end
