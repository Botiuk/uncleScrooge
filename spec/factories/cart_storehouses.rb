# frozen_string_literal: true

FactoryBot.define do
  factory :cart_storehouse do
    cart { FactoryBot.create(:cart) }
    storehouse { FactoryBot.create(:storehouse) }
  end
end
