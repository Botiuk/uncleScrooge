# frozen_string_literal: true

FactoryBot.define do
  factory :storehouse do
    operation_type { Storehouse.operation_types.keys.sample }
    product { FactoryBot.create(:product) }
    quantity { Faker::Number.between(from: 1, to: 30) }
  end
end
