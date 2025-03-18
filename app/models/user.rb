# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  after_create :create_discount_record

  enum :role, { client: 0, admin: 1 }, default: :client

  has_many :carts, dependent: :destroy
  has_many :delivery_addresses, dependent: :destroy
  has_many :payment_cards, dependent: :destroy
  has_one :discount, dependent: :destroy

  def create_discount_record
    role == 'admin' ? Discount.create(user_id: id, percentage: 15).save : Discount.create(user_id: id).save
  end
end
