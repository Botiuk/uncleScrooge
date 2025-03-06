# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    order_price { Faker::Commerce.price }
    cart { FactoryBot.create(:cart) }
    message { Faker::Lorem.paragraph_by_chars }
    notation { Faker::Movie.quote }
  end
end
