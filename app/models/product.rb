# frozen_string_literal: true

class Product < ApplicationRecord
  validates :price, :name, :description, :quantity_in_stock, presence: true
  validates :name, uniqueness: { message: 'name is already taken' }
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  has_one_attached :picture
end
