# frozen_string_literal: true

class AddAncestryToCategories < ActiveRecord::Migration[8.0]
  def change
    add_column :categories, :ancestry, :string
    add_index :categories, :ancestry
  end
end
