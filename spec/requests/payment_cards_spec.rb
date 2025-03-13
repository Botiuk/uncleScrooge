# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PaymentCards' do
  describe 'non registered user management' do
    it 'cannot GET new and redirects to the sign_in page' do
      get new_payment_card_path
      expect(response).to redirect_to(new_user_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end

    it 'cannot GET edit and redirects to the sign_in page' do
      payment_card = create(:payment_card)
      get edit_payment_card_path(payment_card)
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
      get new_payment_card_path
      expect(response).to be_successful
    end

    it 'can POST create' do
      post payment_cards_path,
           params: { payment_card: attributes_for(:payment_card, user_id: test_user.id) }
      expect(response).to be_redirect
      follow_redirect!
      expect(flash[:notice]).to include(I18n.t('notice.create.payment_card'))
    end

    it 'can GET edit' do
      payment_card = create(:payment_card, user_id: test_user.id)
      get edit_payment_card_path(payment_card)
      expect(response).to be_successful
    end

    it 'cannot GET edit delivery_adress other user' do
      payment_card = create(:payment_card)
      get edit_payment_card_path(payment_card)
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to include I18n.t('alert.cancan_access_denied')
    end

    it 'can PUT update' do
      payment_card = create(:payment_card, user_id: test_user.id, expiry_year: '30')
      put payment_card_path(payment_card), params: { payment_card: { expiry_year: '35' } }
      expect(payment_card.reload.expiry_year).to eq('35')
      expect(response).to redirect_to(user_profile_path)
      expect(flash[:notice]).to include(I18n.t('notice.update.payment_card'))
    end

    it 'can DELETE destroy' do
      payment_card = create(:payment_card, user_id: test_user.id)
      delete payment_card_path(payment_card)
      expect(response).to redirect_to(user_profile_path)
      expect(flash[:notice]).to include(I18n.t('notice.destroy.payment_card'))
    end
  end
end
