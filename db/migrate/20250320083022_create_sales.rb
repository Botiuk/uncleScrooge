# frozen_string_literal: true

class CreateSales < ActiveRecord::Migration[8.0]
  def change
    create_table :sales do |t|
      t.integer :percentage, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
