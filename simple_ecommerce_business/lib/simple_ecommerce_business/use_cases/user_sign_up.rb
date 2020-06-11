# frozen_string_literal: true

require 'clean-architecture'

module SimpleEcommerceBusiness
  module UseCases
    class UserSignUp < CleanArchitecture::UseCases::AbstractUseCase # rubocop:disable Style/Documentation
      contract do
        option :user_gateway

        params do
          required(:email).filled(:string)
          required(:password).filled(:string)
          required(:password_confirmation).filled(:string)
          required(:role).filled(:string)
        end

        rule(:password) do
          if !value.nil? && value.length < 6
            key.failure('must have at least 6 chars')
          end
        end

        rule(:email) do
          unless user_gateway.email_is_available?(values[key_name])
            key.failure('is already taken')
          end
        end

        rule(:password_confirmation) do
          if values[:password] != value
            key.failure('should be the same as password')
          end
        end
      end

      extend Forwardable
      include Dry::Monads::Do.for(:result)

      def result
        valid_params = yield result_of_validating_params
        context(:user_gateway).create_user(
          User.new(
            email: valid_params[:email],
            password: valid_params[:password]
          )
        )
      end
    end
  end
end
