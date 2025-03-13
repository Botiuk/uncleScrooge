# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DeliveryAddresses' do
  describe 'non registered user management' do
    it 'cannot GET new and redirects to the sign_in page' do
      get new_delivery_address_path
      expect(response).to redirect_to(new_user_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end

    it 'cannot GET edit and redirects to the sign_in page' do
      delivery_address = create(:delivery_address)
      get edit_delivery_address_path(delivery_address)
      expect(response).to redirect_to(new_user_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end
  end

  describe 'registered user management (not dependent on role)' do
    let(:test_user) { create(:user, role: %w[client admin].sample) }

    before do
      login_as(test_user, scope: :user)
    end

    it 'can GET new' do
      get new_delivery_address_path
      expect(response).to be_successful
    end

    it 'can POST create' do
      post delivery_addresses_path,
           params: { delivery_address: attributes_for(:delivery_address, user_id: test_user.id) }
      expect(response).to be_redirect
      follow_redirect!
      expect(flash[:notice]).to include(I18n.t('notice.create.delivery_address'))
    end

    it 'can GET edit' do
      delivery_address = create(:delivery_address, user_id: test_user.id)
      get edit_delivery_address_path(delivery_address)
      expect(response).to be_successful
    end

    it 'cannot GET edit delivery_adress other user' do
      delivery_address = create(:delivery_address)
      get edit_delivery_address_path(delivery_address)
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to include I18n.t('alert.cancan_access_denied')
    end

    it 'can PUT update' do
      delivery_address = create(:delivery_address, user_id: test_user.id, country: 'USA')
      put delivery_address_path(delivery_address), params: { delivery_address: { country: 'Canada' } }
      expect(delivery_address.reload.country).to eq('Canada')
      expect(response).to redirect_to(user_profile_path)
      expect(flash[:notice]).to include(I18n.t('notice.update.delivery_address'))
    end

    it 'can DELETE destroy' do
      delivery_address = create(:delivery_address, user_id: test_user.id)
      delete delivery_address_path(delivery_address)
      expect(response).to redirect_to(user_profile_path)
      expect(flash[:notice]).to include(I18n.t('notice.destroy.delivery_address'))
    end
  end
end
