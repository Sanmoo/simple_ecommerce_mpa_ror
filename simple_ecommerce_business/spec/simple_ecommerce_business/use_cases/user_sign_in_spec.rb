# frozen_string_literal: true

require 'simple_ecommerce_business/use_cases/user_sign_in'
require 'simple_ecommerce_business/entities/user'
require 'dry-monads'

module SimpleEcommerceBusiness
  User = Entities::User

  module UseCases
    RSpec.describe UseCases::UserSignIn do
      before do
        @user_gateway = double('user_gateway')

        @params = {
          email: 'test@email.com',
          password: 'test1234',
          context: {
            user_gateway: @user_gateway
          }
        }
      end

      let(:result) do
        UserSignIn.new(UserSignIn.parameters(@params)).result
      end

      context 'given user with email test@email.com and password test1234' do
        before do
          allow(@user_gateway).to receive(:password_match?) do
            Dry::Monads::Failure()
          end

          allow(@user_gateway).to receive(:password_match?)
            .with(
              email: 'test@email.com', password: 'test1234'
            ) { Dry::Monads::Success() }
        end

        it 'signs in the user successfully' do
          expect(result).to be_a Dry::Monads::Success
        end

        context 'when he or she does not provide the correct password' do
          before do
            @params[:password] = "#{@params[:password]}t"
          end

          it 'does not sign that user in' do
            expect(result).to be_a Dry::Monads::Failure
          end
        end
      end
    end
  end
end
