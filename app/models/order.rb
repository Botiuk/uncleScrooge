# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :cart
  has_one :delivery_address_order, dependent: nil
  has_one :payment_card_order, dependent: nil
  has_many :order_items, dependent: nil

  accepts_nested_attributes_for :delivery_address_order, :payment_card_order

  enum :order_status, { active: 0, complecting: 1, sended: 2 }, default: :active
  enum :phone_call, { not_need: 0, please_call: 1 }, default: :not_need
  enum :phone_call_status, { not_avaliable: 0, wait: 1, did_call: 2 }, default: :not_avaliable

  validates :order_price, :order_discount, presence: true
  validates_associated :delivery_address_order, :payment_card_order
end
