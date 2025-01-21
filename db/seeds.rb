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

  ActiveStorage::Blob.create!(
    key: '5l03ux8k0t6veuv95qslnibxrpob',
    filename: 'category_avatar.jpg',
    content_type: 'image/jpeg',
    metadata: '{"identified":true,"width":275,"height":183,"analyzed":true}',
    service_name: 'cloudinary',
    byte_size: 11_078,
    checksum: 'OglxuFkfAO4P0+BxiQcqlA=='
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
  root_categories_childrens_ids.each do |root_category_children_id|
    ActiveStorage::Attachment.create!(
      record_type: 'Category',
      record_id: root_category_children_id,
      name: 'avatar',
      blob_id: 1
    )
    ActionText::RichText.create!(
      record_type: 'Category',
      record_id: root_category_children_id,
      name: 'description',
      body: Faker::Lorem.paragraph_by_chars
    )
  end
  40.times do
    Category.create(
      name: Faker::Address.city,
      parent_id: root_categories_childrens_ids.sample
    )
  end

  ActiveStorage::Blob.create!(
    key: 'feseur4a7bofooa01p1w0jf4njfh',
    filename: 'revers.jpg',
    content_type: 'image/jpeg',
    metadata: '{"identified":true,"width":198,"height":198,"analyzed":true}',
    service_name: 'cloudinary',
    byte_size: 70_858,
    checksum: 'HVeUIKL7pKN4HZqZPHjmig=='
  )

when 'production'

  user = User.where(email: 'svetabotiuk@gmail.com').first_or_initialize
  user.update!(
    password: ENV.fetch('SEEDS_PASS', nil),
    password_confirmation: ENV.fetch('SEEDS_PASS', nil),
    role: 'admin'
  )

end
