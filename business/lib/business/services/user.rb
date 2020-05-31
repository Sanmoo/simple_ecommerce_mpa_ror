# frozen_string_literal: true

require 'dry-validation'

require_relative './call_result'

module Business
  module Services
    # Provide business use cases related to app users
    class User
      # rubocop:disable Style/Documentation
      class NewCustomerContract < Dry::Validation::Contract
        params do
          required(:email).filled(:string)
          required(:password).filled(:string)
        end

        rule(:password) do
          if !value.nil? && value.length < 6
            key.failure('must have at least 6 chars')
          end
        end
      end
      # rubocop:enable Style/Documentation

      private_constant :NewCustomerContract

      def initialize(user_repository)
        @user_repository = user_repository
      end

      def register_new_customer(**args)
        validation_result = NewCustomerContract.new.call(args)
        unless validation_result.success?
          return CallResult.new(nil, validation_result.errors.to_h)
        end

        @user_repository.create(*args)
        CallResult.new
      end
    end
  end
end
