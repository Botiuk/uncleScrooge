# frozen_string_literal: true

class AddUnigueIndexToProducts < ActiveRecord::Migration[8.0]
  def change
    add_index :products, 'lower(name)', unique: true
  end
end
