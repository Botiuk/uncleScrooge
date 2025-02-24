# frozen_string_literal: true

class PaymentCard < ApplicationRecord
  before_validation :clean_card_number

  belongs_to :user

  validates :card_number, :expiry_month, :expiry_year, :cvv, presence: true
  validates :expiry_month, :expiry_year, :cvv, numericality: true
  validates :card_number, format: { with: /\A\d+\z/, message: I18n.t('validation.payment_card.number') },
                          length: { is: 16 }
  validates :expiry_month, comparison: { greater_than: 0, less_than_or_equal_to: 12 }
  validates :expiry_year, comparison: { greater_than_or_equal_to: (Time.zone.today.year - 2000) },
                          length: { is: 2 }
  validates_with PaymentCardValidator
  validates :cvv, length: { is: 3 }

  private

  def clean_card_number
    return if card_number.blank?

    self.card_number = card_number.tr('- ', '')
  end
end
