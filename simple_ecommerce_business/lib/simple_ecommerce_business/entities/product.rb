# frozen_string_literal: true

require 'simple_ecommerce_business/entities/types'
require 'simple_ecommerce_business/entities/application_entity'

# A user in the system, admin or customer
module SimpleEcommerceBusiness
  module Entities
    class Product < ApplicationEntity # rubocop:disable Style/Documentation
      attribute :name, Types::Strict::String
      attribute :description, Types::Strict::String
      attribute :price, Types::Strict::Decimal
      attribute :quantity_in_stock, Types::Strict::Integer
      attribute :picture, Types.Instance(File)
    end
  end
end
