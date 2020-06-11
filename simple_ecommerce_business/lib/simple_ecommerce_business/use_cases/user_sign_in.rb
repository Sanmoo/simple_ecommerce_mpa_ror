# frozen_string_literal: true

require 'clean-architecture'

require 'simple_ecommerce_business/entities/user'

module SimpleEcommerceBusiness
  module UseCases
    class UserSignIn < CleanArchitecture::UseCases::AbstractUseCase # rubocop:disable Style/Documentation
      contract do
        option :user_gateway

        params do
          required(:email).filled(:string)
          required(:password).filled(:string)
        end
      end

      extend Forwardable
      include Dry::Monads::Do.for(:result)

      def result
        valid_params = yield result_of_validating_params
        context(:user_gateway).password_match?(
          email: valid_params[:email],
          password: valid_params[:password]
        )
      end
    end
  end
end
