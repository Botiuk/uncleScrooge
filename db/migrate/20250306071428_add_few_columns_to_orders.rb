# frozen_string_literal: true

class AddFewColumnsToOrders < ActiveRecord::Migration[8.0]
  def change
    change_table :orders, bulk: true do
      add_column :orders, :phone_call, :integer, null: false, default: 0
      add_column :orders, :phone_call_status, :integer, null: false, default: 0
      add_column :orders, :message, :text
      add_column :orders, :notation, :text
    end
  end
end
