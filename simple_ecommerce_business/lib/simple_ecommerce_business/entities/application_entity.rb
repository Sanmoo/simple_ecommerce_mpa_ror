# frozen_string_literal: true

require 'dry-struct'

module SimpleEcommerceBusiness
  module Entities
    class ApplicationEntity < Dry::Struct
      transform_keys(&:to_sym)

      attribute :created_at, Types::Date
    end
  end
end
