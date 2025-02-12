# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product do
  describe 'validations' do
    it 'is valid with valid attributes' do
      product = build(:product)
      expect(product).to be_valid
    end

    it 'is not valid without a name' do
      product = build(:product, name: nil)
      expect(product).not_to be_valid
    end

    it 'is not valid without a price' do
      product = build(:product, price: nil)
      expect(product).not_to be_valid
    end

    it 'is not valid without a category_id' do
      product = build(:product, category_id: nil)
      expect(product).not_to be_valid
    end

    it 'is not valid with same name' do
      product_one = create(:product)
      product_two = build(:product, name: product_one.name)
      expect(product_two).not_to be_valid
    end

    it 'is not valid with same name, case sensetive false' do
      product_one = create(:product)
      product_two = build(:product, name: product_one.name.swapcase)
      expect(product_two).not_to be_valid
    end
  end
end
