# frozen_string_literal: true

FactoryBot.define do
  sequence :product_name do |n|
    "Product#{n} For Testing"
  end
  sequence :description do |n| 
    "Product Description for testing #{n} lorem"
  end

  factory :product do
    name { generate :product_name }
    description { "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing" }
    price { 10.5 }
    quantity_in_stock { 3 }
    picture { fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'test-image.png'), 'image/png') }
  end
end
