# frozen_string_literal: true

class CreatePaymentCardOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :payment_card_orders do |t|
      t.references :payment_card, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
