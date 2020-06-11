# frozen_string_literal: true

require 'simple_ecommerce_business/use_cases/user_sign_up'
require 'simple_ecommerce_business/entities/user'
require 'dry-monads'

module SimpleEcommerceBusiness
  User = Entities::User

  module UseCases
    RSpec.describe UseCases::UserSignUp do
      let(:user_gateway) do
        gateway = double('user_gateway')

        allow(gateway).to receive(:email_is_available?)
          .with('unavailable@email.com') { false }

        allow(gateway).to receive(:email_is_available?)
          .with('available@email.com') { true }

        allow(gateway).to receive(:create_user) do |arg|
          Dry::Monads::Success(arg)
        end

        gateway
      end

      before do
        @entity_params = {
          email: 'available@email.com',
          password: 'teste1',
          password_confirmation: 'teste1',
          role: 'ADMIN'
        }

        @params = @entity_params.merge(
          {
            context: {
              user_gateway: user_gateway
            }
          }
        )
      end

      let(:result) do
        UserSignUp.new(UserSignUp.parameters(@params)).result
      end

      it 'signs up a user successfully' do
        expect(result).to be_a Dry::Monads::Success
        expect(result.value!).to be_a User
      end

      context 'when email is empty' do
        before { @params[:email] = '' }

        it 'fails to sign a user up' do
          expect(result).to be_a Dry::Monads::Failure
          expect(result.failure.full_messages).to contain_exactly(
            'Email must be filled'
          )
        end
      end

      context 'when password is less than 6 chars' do
        before do
          @params[:password] = @params[:password_confirmation] = 'teste'
        end

        it 'fails to sign a user up' do
          expect(result).to be_a Dry::Monads::Failure
          expect(result.failure.full_messages).to contain_exactly(
            'Password must have at least 6 chars'
          )
        end
      end

      context 'when password confirmation does not match' do
        before do
          @params[:password_confirmation] = "#{@params[:password]}t"
        end

        it 'fails to sign a user up' do
          expect(result).to be_a Dry::Monads::Failure
          expect(result.failure.full_messages).to contain_exactly(
            'Password confirmation should be the same as password'
          )
        end
      end
    end
  end
end
