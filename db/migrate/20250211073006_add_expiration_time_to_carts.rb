# frozen_string_literal: true

class AddExpirationTimeToCarts < ActiveRecord::Migration[8.0]
  def change
    add_column :carts, :expiration_time, :datetime, null: false, default: '3025-01-01 00:00:00'
  end
end
