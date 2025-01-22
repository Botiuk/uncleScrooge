# frozen_string_literal: true

class Category < ApplicationRecord
  has_ancestry
  has_one_attached :avatar
  has_rich_text :description

  has_many :products, dependent: nil

  validates :name, presence: true,
                   uniqueness: { case_sensitive: false, scope: :ancestry, message: I18n.t('validation.ancestry.uniq') }
end
