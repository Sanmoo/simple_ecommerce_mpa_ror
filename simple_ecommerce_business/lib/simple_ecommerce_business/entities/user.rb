# frozen_string_literal: true

require 'simple_ecommerce_business/entities/types'
require 'simple_ecommerce_business/entities/application_entity'

# A user in the system, admin or customer
module SimpleEcommerceBusiness
  module Entities
    Role = Types::Strict::String
           .default('CUSTOMER')
           .enum('CUSTOMER', 'ADMIN')

    # A user in the system, admin or customer
    class User < ApplicationEntity
      attribute :email, Types::Strict::String
      attribute :password, Types::Strict::String
      attribute :role, Role
    end
  end
end
