# frozen_string_literal: true

require 'dry-validation'

require 'simple_ecommerce_business/support/use_case_result'

module SimpleEcommerceBusiness
  module UseCases
    # Provide business use cases related to app users
    class UserSignUp
      class Contract < Dry::Validation::Contract # rubocop:disable Documentation
        params do
          required(:email).filled(:string)
          required(:password).filled(:string)
          required(:password_confirmation).filled(:string)
        end

        rule(:password) do
          if !value.nil? && value.length < 6
            key.failure('must have at least 6 chars')
          end
        end

        rule(:password_confirmation) do
          if values[:password] != value
            key.failure('should be the same as password')
          end
        end
      end

      private_constant :UserContract

      def initialize(user_repository)
        @user_repository = user_repository
      end

      def call(**args)
        validation_result = UserContract.new.call(args)
        unless validation_result.success?
          return UseCaseResult.new(nil, validation_result.errors.to_h)
        end

        user = User.new(email: args[:email], password: args[:password])

        @user_repository.create(*args)
        CallResult.new
      end
    end
  end
end
