# frozen_string_literal: true

class PaymentCardValidator < ActiveModel::Validator
  def validate(rec)
    return if rec.expiry_month.nil? || rec.expiry_year.nil?

    return unless rec.expiry_year == (Time.zone.today.year - 2000) && rec.expiry_month < Time.zone.today.month

    rec.errors.add :base, I18n.t('validation.payment_card.expiry')
  end
end
