# frozen_string_literal: true

class Cart < ApplicationRecord
  belongs_to :user

  enum :cart_status, { active: 0, paided: 1 }, default: :active
end
