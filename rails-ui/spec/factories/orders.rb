FactoryBot.define do
  factory :order do
    user { nil }
    delivery_address { "MyText" }
  end
end
