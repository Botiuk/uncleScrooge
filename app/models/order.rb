# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :cart
  has_one :delivery_address_order, dependent: nil
  has_one :payment_card_order, dependent: nil

  enum :order_status, { active: 0, complecting: 1, sended: 2 }, default: :active

  validates :order_price, presence: true
end
