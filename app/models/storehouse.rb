# frozen_string_literal: true

class Storehouse < ApplicationRecord
  belongs_to :product

  has_one :cart_storehouse, dependent: :destroy
  has_one :cart, through: :cart_storehouse, dependent: nil

  enum :operation_type, { input: 0, cart: 1, paided: 2 }

  validates :operation_type, :quantity, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }

  def self.count_product_by_operation_type(product_id, operation_type)
    Storehouse.where(product_id: product_id, operation_type: operation_type).sum(:quantity)
  end

  def self.count_avaliable_product(product_id)
    product_input = Storehouse.count_product_by_operation_type(product_id, 'input')
    product_output = Storehouse.count_product_by_operation_type(product_id, %w[cart paided])
    product_input - product_output
  end
end
