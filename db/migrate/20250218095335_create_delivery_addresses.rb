# frozen_string_literal: true

class CreateDeliveryAddresses < ActiveRecord::Migration[8.0]
  def change
    create_table :delivery_addresses do |t|
      t.integer :post_service, null: false
      t.string :country, null: false
      t.string :locality, null: false
      t.string :address, null: false
      t.string :personal_name, null: false
      t.string :phone, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
