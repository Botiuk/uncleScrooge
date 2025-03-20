# frozen_string_literal: true

class Sale < ApplicationRecord
  belongs_to :product

  validates :percentage, :start_date, :end_date, presence: true
  validates :percentage, numericality: { only_integer: true, in: (15..50) }
  validates :end_date, comparison: { greater_than: :start_date }
end
