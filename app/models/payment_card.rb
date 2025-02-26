# frozen_string_literal: true

class PaymentCard < ApplicationRecord
  before_validation :clean_card_number

  belongs_to :user
  has_many :payment_card_order, dependent: :destroy

  validates :card_number, :expiry_month, :expiry_year, :cvv,
            presence: true,
            format: { with: /\A\d+\z/, message: I18n.t('validation.payment_card.only_digits') }
  validates :card_number, length: { is: 16 }
  validates :expiry_month, :expiry_year, length: { is: 2 }
  validates :cvv, length: { is: 3 }
  validates_with PaymentCardValidator

  private

  def clean_card_number
    return if card_number.blank?

    self.card_number = card_number.tr('- ', '')
  end
end
