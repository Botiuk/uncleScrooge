# frozen_string_literal: true

class CreateDiscounts < ActiveRecord::Migration[8.0]
  def change
    create_table :discounts do |t|
      t.decimal :spent_money, precision: 8, scale: 2, null: false, default: 0.00
      t.integer :percentage, null: false, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
