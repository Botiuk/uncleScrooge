# frozen_string_literal: true

class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :storehouse

  validates :product_price, presence: true
end
