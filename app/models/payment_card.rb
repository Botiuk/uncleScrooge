# frozen_string_literal: true

class PaymentCard < ApplicationRecord
  belongs_to :user

  validates :card_number, :expiry_month, :expiry_year, :cvv, presence: true
  validates :expiry_month, :expiry_year, :cvv, numericality: true
  validates :card_number, format: { with: /\A\d+\z/, message: I18n.t('validation.payment_card.number') },
                          length: { is: 16 }
  validates :expiry_month, comparison: { greater_than: 0, less_than_or_equal_to: 12 }
  validates :expiry_year, comparison: { greater_than_or_equal_to: Time.zone.today.year.to_s.delete_prefix('20').to_i },
                          length: { is: 2 }
  validates :cvv, length: { is: 3 }
end
