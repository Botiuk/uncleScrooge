# frozen_string_literal: true

FactoryBot.define do
  factory :delivery_address do
    post_service { DeliveryAddress.post_services.keys.sample }
    country { Faker::Address.country }
    locality { Faker::Address.city }
    address { "#{Faker::Address.street_name} #{Faker::Number.within(range: 1..33)}" }
    personal_name { Faker::Name.name }
    phone { Faker::PhoneNumber.cell_phone }
    user { FactoryBot.create(:user) }
  end
end
