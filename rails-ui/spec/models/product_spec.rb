# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  it 'validates that the price is not empty' do
    expect(build(:product, price: nil)).not_to be_valid
  end

  it 'validates that the name and description are not empty' do
    expect(build(:product, name: '')).not_to be_valid
    expect(build(:product, description: nil)).not_to be_valid
  end

  it 'validates that quantity_in_stock is not empty' do
    expect(build(:product, quantity_in_stock: nil)).not_to be_valid
  end

  it 'validates that the price is not smaller than zero' do
    expect(build(:product, price: -10)).not_to be_valid
  end

  context 'given there is already a product named XYZ' do
    before do
      create(:product, name: 'XYZ')
    end

    it 'validates that the name is unique' do
      expect(build(:product, name: 'XYZ')).not_to be_valid
      expect(build(:product, name: 'Another')).to be_valid
    end
  end
end
