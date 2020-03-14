FactoryBot.define do
  factory :order_item do
    product { nil }
    quantity { 1 }
    unitary_price { "9.99" }
    order { nil }
  end
end
