# frozen_string_literal: true

require 'simple_ecommerce_business/support/types'

require_relative './application_entity'

# A user in the system, admin or customer
module SimpleEcommerceBusiness
  module Entities
    # A user in the system, admin or customer
    class User < ApplicationEntity
      attribute :email, Types::Strict::String
      attribute :password, Types::Strict::String
      attribute :role, Types::Strict::String
        .default('CUSTOMER')
        .enum('CUSTOMER', 'ADMIN')
    end
  end
end
