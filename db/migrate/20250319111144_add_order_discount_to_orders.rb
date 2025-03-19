# frozen_string_literal: true

class AddOrderDiscountToOrders < ActiveRecord::Migration[8.0]
  def change
    add_column :orders, :order_discount, :decimal, precision: 8, scale: 2, null: false, default: 0.00
  end
end
