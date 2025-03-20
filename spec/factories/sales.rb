# frozen_string_literal: true

FactoryBot.define do
  factory :sale do
    date = Faker::Date.between(from: 7.days.ago, to: 7.days.from_now)
    percentage { Faker::Number.within(range: 15..50) }
    start_date { date }
    end_date { date + 7.days }
    product { FactoryBot.create(:product) }
  end
end
