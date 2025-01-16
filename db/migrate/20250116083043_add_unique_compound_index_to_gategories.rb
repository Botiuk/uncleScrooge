# frozen_string_literal: true

class AddUniqueCompoundIndexToGategories < ActiveRecord::Migration[8.0]
  def change
    add_index :categories, 'lower(name), "ancestry"', unique: true
  end
end
