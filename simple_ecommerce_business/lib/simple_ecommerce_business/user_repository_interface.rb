# frozen_string_literal: true

require 'duckface'

module SimpleEcommerceBusiness
  # Interface responsible for abstracting user related datastore operations
  module UserRepositoryInterface
    extend Duckface::ActAsInterface

    def create_user(_user)
      raise NotImplementedMethod
    end
  end
end
