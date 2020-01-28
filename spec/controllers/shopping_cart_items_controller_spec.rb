# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ShoppingCartItemsController, type: :controller do
  describe 'POST #create' do
    it 'returns http success' do
      post :create, params: { product_id: 5 }
      expect(response).to redirect_to(home_show_path)
    end
  end
end
