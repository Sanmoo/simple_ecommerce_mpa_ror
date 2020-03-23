# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'user@test.com' }
    password { '123456' }
    role { 'CUSTOMER' }

    trait :admin do
      role { 'ADMIN' }
    end
  end
end
