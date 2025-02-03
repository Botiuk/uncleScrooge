# frozen_string_literal: true

class Storehouse < ApplicationRecord
  belongs_to :product

  enum :operation_type, { input: 0, cart: 1, paided: 2 }

  validates :operation_type, :quantity, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
end
