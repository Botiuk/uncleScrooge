# frozen_string_literal: true

class DeliveryAddressOrder < ApplicationRecord
  belongs_to :delivery_address
  belongs_to :order
end
