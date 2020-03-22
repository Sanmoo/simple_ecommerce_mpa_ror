# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'user@test.com' }
    password { '123456' }

    factory :admin_user do
      role { 'ADMIN' }
    end

    factory :customer_user do
      role { 'CUSTOMER' }
    end
  end
end
