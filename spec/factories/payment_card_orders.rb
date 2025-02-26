# frozen_string_literal: true

FactoryBot.define do
  factory :payment_card_order do
    payment_card { FactoryBot.create(:payment_card) }
    order { FactoryBot.create(:order) }
  end
end
