# frozen_string_literal: true

require 'faker'

case Rails.env
when 'development'

  User.create(
    email: 'svetabotiuk@gmail.com',
    password: ENV.fetch('SEEDS_PASS', nil),
    password_confirmation: ENV.fetch('SEEDS_PASS', nil),
    role: 'admin'
  )

  User.create(
    email: 'user@gmail.com',
    password: ENV.fetch('SEEDS_PASS', nil),
    password_confirmation: ENV.fetch('SEEDS_PASS', nil)
  )

  ['Монети', 'Набори монет', 'Аксесуари'].each do |category_name|
    Category.create(
      name: category_name
    )
  end
  root_categories_ids = Category.where(ancestry: nil).ids
  10.times do
    Category.create(
      name: Faker::Address.country,
      parent_id: root_categories_ids.sample
    )
  end
  root_categories_childrens_ids = Category.where.not(ancestry: nil).ids
  40.times do
    Category.create(
      name: Faker::Address.city,
      parent_id: root_categories_childrens_ids.sample
    )
  end

when 'production'

  user = User.where(email: 'svetabotiuk@gmail.com').first_or_initialize
  user.update!(
    password: ENV.fetch('SEEDS_PASS', nil),
    password_confirmation: ENV.fetch('SEEDS_PASS', nil),
    role: 'admin'
  )

end
