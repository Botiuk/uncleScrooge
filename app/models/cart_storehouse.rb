# frozen_string_literal: true

class CartStorehouse < ApplicationRecord
  belongs_to :cart
  belongs_to :storehouse
end
