# frozen_string_literal: true

class CreateOrderItems < ActiveRecord::Migration[8.0]
  def change
    create_table :order_items do |t|
      t.decimal :product_price, precision: 8, scale: 2, null: false
      t.references :order, null: false, foreign_key: true
      t.references :storehouse, null: false, foreign_key: true

      t.timestamps
    end
  end
end
