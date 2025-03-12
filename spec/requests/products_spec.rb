# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Products' do
  describe 'non registered user management' do
    it 'cannot GET index' do
      get products_path
      expect(response).to redirect_to(new_user_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end

    it 'cannot GET new and redirects to the sign_in page' do
      get new_product_path
      expect(response).to redirect_to(new_user_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end

    it 'cannot GET edit and redirects to the sign_in page' do
      product = create(:product)
      get edit_product_path(product)
      expect(response).to redirect_to(new_user_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end

    it 'can GET show' do
      product = create(:product)
      get product_path(product)
      expect(response).to be_successful
    end

    it 'GET search' do
      get search_path(product_name: '1 dollar')
      expect(response).to be_successful
    end

    it 'GET search with empty params product_name' do
      get search_path
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to include(I18n.t('alert.search.product'))
    end
  end

  describe 'registered user management' do
    let(:test_user) { create(:user) }

    before do
      login_as(test_user, scope: :user)
    end

    it 'cannot GET index' do
      get products_path
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to include I18n.t('alert.cancan_access_denied')
    end

    it 'cannot GET new and redirects to root page' do
      get new_product_path
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to include I18n.t('alert.cancan_access_denied')
    end

    it 'cannot GET edit and redirects to root page' do
      product = create(:product)
      get edit_product_path(product)
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to include I18n.t('alert.cancan_access_denied')
    end

    it 'can GET show' do
      product = create(:product)
      get product_path(product)
      expect(response).to be_successful
    end

    it 'GET search' do
      get search_path(product_name: '1 dollar')
      expect(response).to be_successful
    end

    it 'GET search with empty params product_name' do
      get search_path
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to include(I18n.t('alert.search.product'))
    end
  end

  describe 'user-admin management' do
    let(:test_user) { create(:user, role: 'admin') }

    before do
      login_as(test_user, scope: :user)
    end

    it 'can GET index' do
      get products_path
      expect(response).to be_successful
    end

    it 'can GET new' do
      get new_product_path
      expect(response).to be_successful
    end

    it 'can POST create' do
      category = create(:category)
      post products_path, params: { product: attributes_for(:product, category_id: category.id) }
      expect(response).to be_redirect
      follow_redirect!
      expect(flash[:notice]).to include(I18n.t('notice.create.product'))
    end

    it 'can GET edit' do
      product = create(:product)
      get edit_product_path(product)
      expect(response).to be_successful
    end

    it 'can PUT update' do
      product = create(:product, name: '1 dolar 1999')
      put product_path(product), params: { product: { name: '5 euro 2000' } }
      expect(product.reload.name).to eq('5 euro 2000')
      expect(response).to redirect_to(product_url(product))
      expect(flash[:notice]).to include(I18n.t('notice.update.product'))
    end

    it 'can GET show' do
      product = create(:product)
      get product_path(product)
      expect(response).to be_successful
    end

    it 'GET search' do
      get search_path(product_name: '1 dollar')
      expect(response).to be_successful
    end

    it 'GET search with empty params product_name' do
      get search_path
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to include(I18n.t('alert.search.product'))
    end
  end
end
