# frozen_string_literal: true

class CreatePaymentCards < ActiveRecord::Migration[8.0]
  def change
    create_table :payment_cards do |t|
      t.string :card_number, null: false
      t.integer :expiry_month, null: false
      t.integer :expiry_year, null: false
      t.integer :cvv, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
