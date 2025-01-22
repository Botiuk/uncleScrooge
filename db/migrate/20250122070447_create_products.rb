# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.decimal :price, precision: 8, scale: 2, null: false, default: 0.00
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
