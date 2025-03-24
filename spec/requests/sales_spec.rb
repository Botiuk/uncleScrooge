# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sales' do
  describe 'non registered user management' do
    it 'cannot GET index' do
      get sales_path
      expect(response).to redirect_to(new_user_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end

    it 'cannot GET new and redirects to the sign_in page' do
      get new_sale_path
      expect(response).to redirect_to(new_user_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end

    it 'cannot GET edit and redirects to the sign_in page' do
      sale = create(:sale)
      get edit_sale_path(sale)
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
      get sales_path
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to include I18n.t('alert.cancan_access_denied')
    end

    it 'cannot GET new and redirects to root page' do
      get new_sale_path
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to include I18n.t('alert.cancan_access_denied')
    end

    it 'cannot GET edit and redirects to root page' do
      sale = create(:sale)
      get edit_sale_path(sale)
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
      get sales_path
      expect(response).to be_successful
    end

    it 'can GET new' do
      get new_sale_path
      expect(response).to be_successful
    end

    it 'can POST create' do
      product = create(:product)
      post sales_path, params: { sale: attributes_for(:sale, product_id: product.id) }
      expect(response).to be_redirect
      follow_redirect!
      expect(flash[:notice]).to include(I18n.t('notice.create.sale'))
    end

    it 'can GET edit' do
      sale = create(:sale)
      get edit_sale_path(sale)
      expect(response).to be_successful
    end

    it 'can PUT update' do
      sale = create(:sale, percentage: 20)
      put sale_path(sale), params: { sale: { percentage: 40 } }
      expect(sale.reload.percentage).to eq(40)
      expect(response).to redirect_to(sales_url)
      expect(flash[:notice]).to include(I18n.t('notice.update.sale'))
    end

    it 'can DELETE destroy, input sale' do
      sale = create(:sale)
      delete sale_path(sale)
      expect(response).to redirect_to(sales_url)
      expect(flash[:notice]).to include(I18n.t('notice.destroy.sale'))
    end
  end
end
