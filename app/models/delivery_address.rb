# frozen_string_literal: true

class DeliveryAddress < ApplicationRecord
  belongs_to :user

  enum :post_service, { ukrpost: 0, newpost: 1 }

  validates :post_service, :country, :locality, :address, :personal_name, :phone, presence: true
end
