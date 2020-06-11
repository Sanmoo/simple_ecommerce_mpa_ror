# frozen_string_literal: true

require 'business/services/user'

RSpec.describe Business::Services::User do
  before do
    @user_repository = double('user_repository')
    @user_service = Business::Services::User.new(@user_repository)
  end

  it 'does not register a user with empty email' do
    result = @user_service.register_new_customer(password: 'testes')
    expect(result).not_to be_successful
    expect(result.errors).to include(:email)
    expect(result.errors).not_to include(:password)
  end

  it 'does not register a user with less than 6 chars in password' do
    result = @user_service.register_new_customer(
      password: 'teste',
      email: 'test@domain.com'
    )
    expect(result).not_to be_successful
    expect(result.errors).not_to include(:email)
    expect(result.errors).to include(:password)
  end

  it 'registers a user with proper email and password' do
    expect(@user_repository).to receive(:create)
      .with([:password, 'testes'], [:email, 'test@domain.com'])
    result = @user_service.register_new_customer(
      password: 'testes',
      email: 'test@domain.com'
    )
    expect(result).to be_successful
  end
end
