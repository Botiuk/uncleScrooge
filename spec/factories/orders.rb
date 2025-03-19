# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    price = Faker::Commerce.price
    order_price { price }
    order_discount { price * 0.01 * Faker::Number.within(range: 1..10) }
    cart { FactoryBot.create(:cart) }
    message { Faker::Lorem.paragraph_by_chars }
    notation { Faker::Movie.quote }
  end
end
