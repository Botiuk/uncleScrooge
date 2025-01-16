# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category do
  describe 'validations' do
    it 'is valid with valid attributes (ancestry not set in factory)' do
      category = build(:category)
      expect(category).to be_valid
    end

    it 'is not valid without a name' do
      category = build(:category, name: nil)
      expect(category).not_to be_valid
    end

    it 'is valid without a ancestry' do
      category = build(:category, ancestry: nil)
      expect(category).to be_valid
    end

    it 'is not valid with the same name (root categories), case sensitive false' do
      category_one = create(:category)
      category_two = build(:category, name: category_one.name.swapcase)
      expect(category_two).not_to be_valid
    end

    it 'is not valid with the same name (one parent childrens categories), case sensitive false' do
      category_one = create(:category)
      category_two = create(:category, parent_id: category_one.id)
      category_third = build(:category, parent_id: category_one.id, name: category_two.name.swapcase)
      expect(category_third).not_to be_valid
    end

    it 'is valid with the same name (different parent childrens categories), case sensitive false' do
      category_one = create(:category)
      category_two = create(:category)
      category_third = create(:category, parent_id: category_one.id)
      category_fourth = build(:category, parent_id: category_two.id, name: category_third.name.swapcase)
      expect(category_fourth).to be_valid
    end
  end
end
