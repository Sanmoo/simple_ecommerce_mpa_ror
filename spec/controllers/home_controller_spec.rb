# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  before(:all) do
    @admin = User.create!(email: 'admin@test.com', password: '123456')
  end

  before do
    sign_in @admin
  end

  after do
    sign_out @admin
  end

  describe 'GET #show' do
    it 'returns http success' do
      get :show
      expect(response).to have_http_status(:success)
    end
  end
end
