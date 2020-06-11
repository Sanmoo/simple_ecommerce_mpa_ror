# frozen_string_literal: true

require 'dry-struct'
require 'simple_ecommerce_business/entities/types'

module SimpleEcommerceBusiness
  module Entities
    # Parent of all entities
    class ApplicationEntity < Dry::Struct
      transform_keys(&:to_sym)

      attribute :created_at, (Types::DateTime.default { DateTime.now })
    end
  end
end