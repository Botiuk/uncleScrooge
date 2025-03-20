# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :category
  has_many :storehouses, dependent: nil
  has_many :sales, dependent: nil

  has_many_attached :photos
  has_rich_text :description

  validates :name, :price, presence: true
  validates :name, uniqueness: { case_sensitive: false }
end
