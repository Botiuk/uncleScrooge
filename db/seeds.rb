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
  ActiveStorage::Blob.create!(
    key: 'aljfox6cbhtgiphmw8k8ao3n6rix',
    filename: 'avers.jpg',
    content_type: 'image/jpeg',
    metadata: '{"identified":true,"width":198,"height":198,"analyzed":true}',
    service_name: 'cloudinary',
    byte_size: 72_935,
    checksum: 'QlDJbDTcZjd+aS4Ne6B+Rw=='
  )

  root_coin_category = Category.where(ancestry: nil, name: 'Монети').first
  last_childrens_ids = root_coin_category.indirect_ids
  nominal = [1, 2, 5, 10, 20, 50, 100]
  last_childrens_ids.each do |last_children_id|
    rand(3..8).times do
      year = Faker::Date.between(from: 200.years.ago, to: Time.zone.today).year
      Product.create(
        name: "#{nominal.sample} #{Faker::Coin.name} #{year}",
        price: Faker::Commerce.price,
        category_id: last_children_id
      )
    end
  end

  product_ids = Product.ids
  coins_blobs = [2, 3]
  product_ids.each do |product_id|
    coins_blobs.each do |coin_blob|
      ActiveStorage::Attachment.create!(
        record_type: 'Product',
        record_id: product_id,
        name: 'photos',
        blob_id: coin_blob
      )
    end
    ActionText::RichText.create!(
      record_type: 'Product',
      record_id: product_id,
      name: 'description',
      body: Faker::Quote.yoda
    )
    Storehouse.create(
      operation_type: 'input',
      product_id: product_id,
      quantity: Faker::Number.between(from: 1, to: 30)
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
