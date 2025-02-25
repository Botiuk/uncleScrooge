# frozen_string_literal: true

class CleanExpiryPaymentCardJob < ApplicationJob
  queue_as :default

  def perform
    month_now = Time.zone.today.month.to_s
    year_now = (Time.zone.today.year - 2000).to_s
    expiry_payment_cards = PaymentCard.where('expiry_year <= ? AND expiry_month < ?', year_now, month_now)
    expiry_payment_cards.each(&:destroy)
  end
end
