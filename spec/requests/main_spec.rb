# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Main' do
  describe 'non registered user management' do
    it 'can GET index' do
      get root_path
      expect(response).to be_successful
    end

    it 'can GET contacts' do
      get contacts_path
      expect(response).to be_successful
    end

    it 'cannot GET user_profile' do
      get user_profile_path
      expect(response).to redirect_to(new_user_session_path)
      expect(flash[:alert]).to include I18n.t('devise.failure.unauthenticated')
    end
  end

  describe 'registered user management (not dependent on role)' do
    let(:test_user) { create(:user, role: %w[client admin].sample) }

    before do
      login_as(test_user, scope: :user)
    end

    it 'can GET index' do
      get root_path
      expect(response).to be_successful
    end

    it 'can GET contacts' do
      get contacts_path
      expect(response).to be_successful
    end

    it 'can GET user_profile' do
      get user_profile_path
      expect(response).to be_successful
    end
  end
end
