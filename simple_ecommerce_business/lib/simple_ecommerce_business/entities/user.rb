# frozen_string_literal: true

require 'simple_ecommerce_business/support/types'

# A user in the system, admin or customer
class User < ApplicationEntity
  attribute :email, Types::String
  attribute :password, Types::String
  attribute :role, Types::String.default('CUSTOMER')
end
