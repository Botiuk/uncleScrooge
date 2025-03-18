# frozen_string_literal: true

class Discount < ApplicationRecord
  belongs_to :user

  validates :percentage, numericality: { only_integer: true, in: (0..100) }
  validates :spent_money, numericality: { greater_than_or_equal_to: 0 }
end
