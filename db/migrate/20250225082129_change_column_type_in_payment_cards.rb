# frozen_string_literal: true

class ChangeColumnTypeInPaymentCards < ActiveRecord::Migration[8.0]
  def up
    change_table :payment_cards, bulk: true do |t|
      t.change :expiry_month, :string
      t.change :expiry_year, :string
      t.change :cvv, :string
    end
  end

  def down
    change_table :payment_cards, bulk: true do |t|
      t.change :expiry_month, :integer
      t.change :expiry_year, :integer
      t.change :cvv, :integer
    end
  end
end
