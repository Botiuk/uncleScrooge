# frozen_string_literal: true

class CreateCartStorehouses < ActiveRecord::Migration[8.0]
  def change
    create_table :cart_storehouses do |t|
      t.references :cart, null: false, foreign_key: true
      t.references :storehouse, null: false, foreign_key: true

      t.timestamps
    end
  end
end
