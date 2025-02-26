# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.integer :order_status, null: false, default: 0
      t.decimal :order_price, precision: 8, scale: 2, null: false
      t.references :cart, null: false, foreign_key: true

      t.timestamps
    end
  end
end
