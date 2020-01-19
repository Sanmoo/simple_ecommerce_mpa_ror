# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with password and username' do
    expect(build(:user)).to be_valid
  end

  it 'is not valid without a password' do
    expect(build(:user, password: '')).not_to be_valid
  end

  it 'is not valid without email' do
    expect(build(:user, email: '')).not_to be_valid
  end

  it 'is not valid with an email smaller than 6 characters' do
    expect(build(:user, password: '12345')).not_to be_valid
  end
end
