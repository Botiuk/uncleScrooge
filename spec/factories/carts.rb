# frozen_string_literal: true

FactoryBot.define do
  factory :cart do
    user { FactoryBot.create(:user) }
  end
end
