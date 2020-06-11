# frozen_string_literal: true

require 'dry-struct'
require 'dry-validation'
require 'dry-types'

module SimpleEcommerceBusiness
  module Entities
    module Types # rubocop:disable Style/Documentation
      include Dry.Types()
    end
  end
end
