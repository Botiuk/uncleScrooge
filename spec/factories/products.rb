# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    nominal = [1, 2, 5, 10, 20, 50, 100].sample
    year = Faker::Date.between(from: 200.years.ago, to: Time.zone.today).year
    name { "#{nominal} #{Faker::Coin.name} #{year}" }
    price { Faker::Commerce.price }
    category { FactoryBot.create(:category) }
  end
end
