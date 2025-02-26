# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :cart

  enum :order_status, { active: 0, complecting: 1, sended: 2 }, default: :active

  validates :order_price, presence: true
end
