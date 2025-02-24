# frozen_string_literal: true

FactoryBot.define do
  factory :payment_card do
    card_number { Faker::Alphanumeric.alphanumeric(number: 16, min_numeric: 16) }
    expiry_month { rand(1..12) }
    expiry_year do
      Faker::Date.between(from: (Time.zone.today + 1.year), to: '2099-12-31').year.to_s.delete_prefix('20').to_i
    end
    cvv { Faker::Number.number(digits: 3) }
    user { FactoryBot.create(:user) }
  end
end
