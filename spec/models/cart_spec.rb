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
end
