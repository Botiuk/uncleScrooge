# frozen_string_literal: true

class CreateStorehouses < ActiveRecord::Migration[8.0]
  def change
    create_table :storehouses do |t|
      t.integer :operation_type, null: false
      t.references :product, null: false, foreign_key: true
      t.integer :quantity, null: false

      t.timestamps
    end
  end
end
