# frozen_string_literal: true

FactoryBot.define do
  factory :delivery_address_order do
    delivery_address { FactoryBot.create(:delivery_address) }
    order { FactoryBot.create(:order) }
  end
end
