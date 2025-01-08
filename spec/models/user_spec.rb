# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'is not valid without a email' do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
    end

    it 'is not valid with not unique email' do
      user_one = create(:user)
      user_two = build(:user, email: user_one.email)
      expect(user_two).not_to be_valid
    end

    it 'is not valid without a password' do
      user = build(:user, password: nil)
      expect(user).not_to be_valid
    end

    it 'is not valid with a password shorter than 6 symbols' do
      user = build(:user, password: '12345', password_confirmation: '12345')
      expect(user).not_to be_valid
    end

    it 'is valid with a password with 6 symbols' do
      user = build(:user, password: '123456', password_confirmation: '123456')
      expect(user).to be_valid
    end
  end

  describe 'role when' do
    it 'role does not set in factory' do
      user = build(:user)
      expect(user.role).to eq('client')
    end

    it 'role put on create' do
      user = build(:user, role: 'admin')
      expect(user.role).to eq('admin')
    end

    it 'role put on change' do
      user = create(:user, role: 'client')
      user.role = 'admin'
      user.save
      expect(user.role).to eq('admin')
    end
  end
end
