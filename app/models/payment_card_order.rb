# frozen_string_literal: true

class PaymentCardOrder < ApplicationRecord
  belongs_to :payment_card
  belongs_to :order
end
