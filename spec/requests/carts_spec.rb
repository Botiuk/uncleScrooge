# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Carts' do
  describe 'non registered user management' do
    it 'cannot GET my_cart' do
      create(:cart)
      get my_cart_path
      expect(response).to redirect_to(new_user_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end
  end

  describe 'registered user management (not dependent on role)' do
    let(:test_user) { create(:user, role: %w[client admin].sample) }
    let(:cart) { create(:cart, user_id: test_user.id) }
    let(:product) { create(:product) }

    before do
      login_as(test_user, scope: :user)
    end

    it 'can DELETE destroy' do
      delete cart_path(cart)
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to include(I18n.t('notice.destroy.cart'))
    end

    it 'can GET my_cart' do
      get my_cart_path
      expect(response).to be_successful
    end

    it 'can POST add_to_cart when product quantity >= cart' do
      input_storehouse = create(:storehouse, product_id: product.id, operation_type: 'input')
      post add_to_cart_path, params: { product_id: product.id, quantity: input_storehouse.quantity }
      expect(response).to be_redirect
      follow_redirect!
      expect(flash[:notice]).to include(I18n.t('notice.create.product_to_cart'))
    end

    it 'can POST add_to_cart when product quantity < cart' do
      input_storehouse = create(:storehouse, product_id: product.id, operation_type: 'input')
      post add_to_cart_path, params: { product_id: product.id, quantity: (input_storehouse.quantity + 1) }
      expect(response).to be_redirect
      follow_redirect!
      expect(flash[:alert]).to include(I18n.t('alert.update.part_add_to_cart'))
    end

    it 'can POST add_to_cart when product quantity = 0' do
      post add_to_cart_path, params: { product_id: product.id, quantity: 1 }
      expect(response).to be_redirect
      follow_redirect!
      expect(flash[:alert]).to include(I18n.t('alert.update.not_add_to_cart'))
    end

    it 'can POST remove_from_cart' do
      cart_storehouse = create(:cart_storehouse, cart_id: cart.id)
      post remove_from_cart_path, params: { id: cart_storehouse.storehouse_id }
      expect(response).to be_redirect
      follow_redirect!
      expect(flash[:notice]).to include(I18n.t('notice.destroy.product_from_cart'))
    end

    it 'can POST minus_one_item when product in cart one item' do
      storehouse = create(:storehouse, quantity: 1, operation_type: 'cart')
      create(:cart_storehouse, cart_id: cart.id, storehouse_id: storehouse.id)
      post minus_one_item_path, params: { id: storehouse.id }
      expect(response).to be_redirect
      follow_redirect!
      expect(flash[:notice]).to include(I18n.t('notice.destroy.product_from_cart'))
    end

    it 'can POST minus_one_item when product in cart many item' do
      storehouse = create(:storehouse, quantity: 5, operation_type: 'cart')
      create(:cart_storehouse, cart_id: cart.id, storehouse_id: storehouse.id)
      post minus_one_item_path, params: { id: storehouse.id }
      expect(response).to be_redirect
      expect(storehouse.reload.quantity).to eq(4)
    end

    it 'can POST plus_one_item when product in cart < product quantity' do
      storehouse_input = create(:storehouse, quantity: 5, operation_type: 'input')
      storehouse = create(:storehouse, quantity: 4, operation_type: 'cart', product_id: storehouse_input.product_id)
      create(:cart_storehouse, cart_id: cart.id, storehouse_id: storehouse.id)
      post plus_one_item_path, params: { id: storehouse.id, product_id: storehouse.product_id }
      expect(response).to be_redirect
      expect(storehouse.reload.quantity).to eq(5)
    end

    it 'can POST plus_one_item when product in cart >= product quantity' do
      storehouse_input = create(:storehouse, operation_type: 'input')
      storehouse = create(:storehouse, quantity: storehouse_input.quantity, operation_type: 'cart',
                                       product_id: storehouse_input.product_id)
      create(:cart_storehouse, cart_id: cart.id, storehouse_id: storehouse.id)
      post plus_one_item_path, params: { id: storehouse.id, product_id: storehouse.product_id }
      expect(response).to be_redirect
      follow_redirect!
      expect(flash[:alert]).to include(I18n.t('alert.update.plus_item_to_cart'))
    end
  end
end
