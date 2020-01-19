# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name { 'Product X' }
    description { 'Description for product' }
    price { 10.5 }
    quantity_in_stock { 3 }
  end
end
