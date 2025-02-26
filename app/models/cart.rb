# frozen_string_literal: true

class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_storehouses, dependent: :destroy
  has_many :storehouses, through: :cart_storehouses, dependent: nil
  has_one :order, dependent: nil

  enum :cart_status, { active: 0, paided: 1 }, default: :active
end
