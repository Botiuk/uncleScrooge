# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Orders' do
  describe 'non registered user management' do
    it 'cannot GET index' do
      get orders_path
      expect(response).to redirect_to(new_user_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end

    it 'cannot GET new and redirects to the sign_in page' do
      get new_order_path
      expect(response).to redirect_to(new_user_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end

    it 'cannot GET edit and redirects to the sign_in page' do
      order = create(:order)
      get edit_order_path(order)
      expect(response).to redirect_to(new_user_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end

    it 'cannot GET show' do
      order = create(:order)
      get order_path(order)
      expect(response).to redirect_to(new_user_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end
  end

  describe 'registered user management' do
    let(:test_user) { create(:user) }

    before do
      login_as(test_user, scope: :user)
    end

    it 'cannot GET index' do
      get orders_path
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to include I18n.t('alert.cancan_access_denied')
    end

    it 'can GET new' do
      get new_order_path
      expect(response).to be_successful
    end

    it 'can POST create' do
      cart = create(:cart, user_id: test_user.id)
      post orders_path, params: { order: attributes_for(:order, cart_id: cart.id) }
      expect(response).to be_redirect
      follow_redirect!
      expect(flash[:notice]).to include(I18n.t('notice.create.order'))
    end

    it 'cannot GET edit and redirects to root page' do
      cart = create(:cart, user_id: test_user.id)
      order = create(:order, cart_id: cart.id)
      get edit_order_path(order)
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to include I18n.t('alert.cancan_access_denied')
    end

    it 'can GET show when it is his order' do
      cart = create(:cart, user_id: test_user.id)
      order = create(:order, cart_id: cart.id)
      get order_path(order)
      expect(response).to be_successful
    end

    it 'cannot GET show when it is not his order' do
      order = create(:order)
      get order_path(order)
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to include I18n.t('alert.cancan_access_denied')
    end
  end

  describe 'user-admin management' do
    let(:test_user) { create(:user, role: 'admin') }

    before do
      login_as(test_user, scope: :user)
    end

    it 'can GET index' do
      get orders_path
      expect(response).to be_successful
    end

    it 'can GET new' do
      get new_order_path
      expect(response).to be_successful
    end

    it 'can POST create' do
      cart = create(:cart, user_id: test_user.id)
      post orders_path, params: { order: attributes_for(:order, cart_id: cart.id) }
      expect(response).to be_redirect
      follow_redirect!
      expect(flash[:notice]).to include(I18n.t('notice.create.order'))
    end

    it 'can GET edit' do
      order = create(:order)
      get edit_order_path(order)
      expect(response).to be_successful
    end

    it 'can PUT update' do
      order = create(:order, order_status: 'active')
      put order_path(order), params: { order: { order_status: 'complecting' } }
      expect(order.reload.order_status).to eq('complecting')
      expect(response).to redirect_to(order_url(order))
      expect(flash[:notice]).to include(I18n.t('notice.update.order'))
    end

    it 'can GET show' do
      order = create(:order)
      get order_path(order)
      expect(response).to be_successful
    end
  end
end
