# frozen_string_literal: true

class Category < ApplicationRecord
  has_ancestry
  has_one_attached :avatar
  has_rich_text :description

  has_many :products, dependent: nil

  validates :name, presence: true,
                   uniqueness: { case_sensitive: false, scope: :ancestry, message: I18n.t('validation.ancestry.uniq') }

  def self.formhelper
    categories = Category.pluck(:name, :id)
    categories.map do |element|
      category = Category.find(element[1])
      element[0] = ''
      category.ancestors.each do |cat|
        element[0] += "#{cat.name} / "
      end
      element[0] += category.name.to_s
    end
    categories.sort
  end
end
