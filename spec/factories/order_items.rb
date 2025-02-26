# frozen_string_literal: true

FactoryBot.define do
  factory :order_item do
    product_price { Faker::Commerce.price }
    order { FactoryBot.create(:order) }
    storehouse { FactoryBot.create(:storehouse) }
  end
end
