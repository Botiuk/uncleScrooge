# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Storehouses' do
  describe 'non registered user management' do
    it 'cannot GET index' do
      get storehouses_path
      expect(response).to redirect_to(new_user_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end

    it 'cannot GET new and redirects to the sign_in page' do
      get new_storehouse_path
      expect(response).to redirect_to(new_user_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end

    it 'cannot GET edit and redirects to the sign_in page' do
      storehouse = create(:storehouse)
      get edit_storehouse_path(storehouse)
      expect(response).to redirect_to(new_user_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end

    it 'cannot GET search' do
      get storehouses_search_path
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
      get storehouses_path
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to include I18n.t('alert.cancan_access_denied')
    end

    it 'cannot GET new and redirects to root page' do
      get new_storehouse_path
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to include I18n.t('alert.cancan_access_denied')
    end

    it 'cannot GET edit and redirects to root page' do
      storehouse = create(:storehouse)
      get edit_storehouse_path(storehouse)
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to include I18n.t('alert.cancan_access_denied')
    end

    it 'cannot GET search' do
      get storehouses_search_path
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
      get storehouses_path
      expect(response).to be_successful
    end

    it 'can GET new' do
      get new_storehouse_path
      expect(response).to be_successful
    end

    it 'can POST create' do
      product = create(:product)
      post storehouses_path, params: { storehouse: attributes_for(:storehouse, product_id: product.id) }
      expect(response).to be_redirect
      follow_redirect!
      expect(flash[:notice]).to include(I18n.t('notice.create.storehouse'))
    end

    it 'can GET edit input storehouse' do
      storehouse = create(:storehouse, operation_type: 'input')
      get edit_storehouse_path(storehouse)
      expect(response).to be_successful
    end

    it 'cannot GET edit, not input storehouse' do
      storehouse = create(:storehouse, operation_type: %w[cart paided].sample)
      get edit_storehouse_path(storehouse)
      expect(flash[:alert]).to include I18n.t('alert.cancan_access_denied')
    end

    it 'can PUT update' do
      storehouse = create(:storehouse, operation_type: 'input', quantity: 5)
      put storehouse_path(storehouse), params: { storehouse: { quantity: 33 } }
      expect(storehouse.reload.quantity).to eq(33)
      expect(response).to redirect_to(storehouses_url)
      expect(flash[:notice]).to include(I18n.t('notice.update.storehouse'))
    end

    it 'can DELETE destroy, input storehouse' do
      storehouse = create(:storehouse, operation_type: 'input')
      delete storehouse_path(storehouse)
      expect(response).to redirect_to(storehouses_url)
      expect(flash[:notice]).to include(I18n.t('notice.destroy.storehouse'))
    end

    it 'cannot DELETE destroy, not input storehouse' do
      storehouse = create(:storehouse, operation_type: %w[cart paided].sample)
      delete storehouse_path(storehouse)
      expect(flash[:alert]).to include I18n.t('alert.cancan_access_denied')
    end

    it 'GET search' do
      storehouse = create(:storehouse)
      get storehouses_search_path(product_id: storehouse.product_id)
      expect(response).to be_successful
    end

    it 'GET search with empty params' do
      get storehouses_search_path
      expect(response).to redirect_to(root_path)
    end
  end
end
