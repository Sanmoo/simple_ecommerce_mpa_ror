# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  # This should return the minimal set of attributes required to create a valid
  # Product. As you add validations to Product, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    attributes_for(:product)
  end

  let(:invalid_attributes) do
    attributes_for(:product, name: nil)
  end

  before do
    @admin = create(:user)
    sign_in @admin
  end

  describe 'GET #index' do
    it 'returns a success response' do
      Product.create! valid_attributes
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      product = Product.create! valid_attributes
      get :show, params: { id: product.to_param }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: {}
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      product = Product.create! valid_attributes
      get :edit, params: { id: product.to_param }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Product' do
        expect do
          post :create, params: { product: valid_attributes }
        end.to change(Product, :count).by(1)
      end

      it 'redirects to the created product' do
        post :create, params: { product: valid_attributes }
        expect(response).to redirect_to(Product.last)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { product: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        valid_attributes.merge(name: 'New name', description: 'New description').except(:price).stringify_keys
      end

      it 'updates the requested product' do
        product = Product.create! valid_attributes
        put :update, params: { id: product.to_param, product: new_attributes }
        product.reload
        expect(product.attributes).to include(new_attributes)
      end

      it 'redirects to the product' do
        product = Product.create! valid_attributes
        put :update, params: { id: product.to_param, product: valid_attributes }
        expect(response).to redirect_to(product)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'edit' template)" do
        product = Product.create! valid_attributes
        put :update, params: { id: product.to_param, product: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested product' do
      product = Product.create! valid_attributes
      expect do
        delete :destroy, params: { id: product.to_param }
      end.to change(Product, :count).by(-1)
    end

    it 'redirects to the products list' do
      product = Product.create! valid_attributes
      delete :destroy, params: { id: product.to_param }
      expect(response).to redirect_to(products_url)
    end
  end
end
