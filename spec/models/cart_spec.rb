# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cart do
  describe 'validations' do
    it 'is valid with valid attributes' do
      cart = build(:cart)
      expect(cart).to be_valid
    end

    it 'is not valid without user_id' do
      cart = build(:cart, user_id: nil)
      expect(cart).not_to be_valid
    end
  end

  describe 'cart_status' do
    it 'cart_status does not set in factory' do
      cart = build(:cart)
      expect(cart.cart_status).to eq('active')
    end

    it 'cart_status put on create' do
      cart = build(:cart, cart_status: 'paided')
      expect(cart.cart_status).to eq('paided')
    end

    it 'cart_status put on change' do
      cart = create(:cart)
      cart.cart_status = 'paided'
      cart.save
      expect(cart.cart_status).to eq('paided')
    end
  end

  describe 'cart expiration_time' do
    it 'expiration_time does not set in factory' do
      cart = build(:cart)
      expect(cart.expiration_time.to_i).to eq('3025-01-01 00:00:00 +0200'.to_datetime.to_i)
    end

    it 'expiration_time put on create' do
      cart_time = DateTime.current + 10.hours
      cart = build(:cart, expiration_time: cart_time)
      expect(cart.expiration_time.to_i).to eq(cart_time.to_i)
    end

    it 'expiration_time put on change' do
      cart = create(:cart)
      cart_time = DateTime.current + 10.hours
      cart.expiration_time = cart_time
      cart.save
      expect(cart.expiration_time.to_i).to eq(cart_time.to_i)
    end
  end
end
