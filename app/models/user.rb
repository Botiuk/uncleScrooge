# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  enum :role, { client: 0, admin: 1 }, default: :client

  has_many :carts, dependent: :destroy
  has_many :delivery_addresses, dependent: :destroy
  has_many :payment_cards, dependent: :destroy
end
