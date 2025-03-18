# frozen_string_literal: true

FactoryBot.define do
  factory :discount do
    spent_money { Faker::Number.decimal(l_digits: 2) }
    percentage { Faker::Number.within(range: 1..10) }
    user { FactoryBot.create(:user) }
  end
end
