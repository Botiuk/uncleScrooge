# frozen_string_literal: true

class PaymentCardValidator < ActiveModel::Validator
  def validate(rec)
    return if rec.expiry_month.nil?

    rec.errors.add :base, I18n.t('validation.payment_card.expiry_month') if rec.expiry_month.to_i > 12

    return if rec.expiry_year.nil?

    if rec.expiry_year.to_i < (Time.zone.today.year - 2000)
      rec.errors.add :base, I18n.t('validation.payment_card.expiry_year')
    end

    return unless rec.expiry_year.to_i <= (Time.zone.today.year - 2000) && rec.expiry_month.to_i < Time.zone.today.month

    rec.errors.add :base, I18n.t('validation.payment_card.expiry')
  end
end
