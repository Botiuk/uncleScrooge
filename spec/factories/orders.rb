# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    order_price { Faker::Commerce.price }
    cart { FactoryBot.create(:cart) }
  end
end
