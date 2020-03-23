# frozen_string_literal: true

require 'features/shared/can_see_products'
require 'rails_helper'

RSpec.feature 'Home page', type: :feature do
  context 'given 4 products are registered' do
    before do
      @products = []
      4.times { @products.push(create(:product)) }
    end

    context 'given the admin user has just logged in' do
      before do
        @admin = create(:user, :admin)
        login_as @admin
        visit '/'
      end

      scenario 'he or she can see the navigation bar with admin menus' do
        expect(find('body > nav')).to have_link('Simple Ecommerce RoR MPA')
        expect(find('body > nav')).to have_link('Products')
        expect(find('body > nav')).to have_link('Log out')
      end

      scenario 'he or she cannot see non admin menus' do
        expect(find('body > nav')).not_to have_link('My Orders')
        expect(find('body > nav')).not_to have_link('My Shopping Cart')
      end

      include_examples 'can see products in the page' do
        let(:products) { @products }
      end

      context 'when they click in the Products menu' do
        before { within('body > nav') { click_on('Products') } }

        scenario 'then they are taken to the products page' do
          expect(current_path).to eq('/products')
        end
      end

      context 'when they click in the Log out menu' do
        before { within('body > nav') { click_on('Log out') } }

        scenario 'then they are kept in the home page but are informed that they logged out' do
          expect(current_path).to eq('/')
          expect(page).to have_text 'Signed out successfully.'
        end
      end
    end

    context 'given the customer user has just logged in' do
      before do
        @customer = create(:user)
        login_as @customer
        visit '/'
      end

      scenario 'he or she can see the navigation menu bar with customer menus' do
        expect(find('body > nav')).to have_link('My Orders')
        expect(find('body > nav')).to have_link('My Shopping Cart')
        expect(find('body > nav')).to have_link('Log out')
      end

      scenario 'he or she cannot see non customer menus' do
        expect(find('body > nav')).not_to have_link('Products')
      end

      include_examples 'can see products in the page' do
        let(:products) { @products }
      end

      context 'when they click in the My Orders menu' do
        before { within('body > nav') { click_on('My Orders') } }

        scenario 'then they are taken to the orders page' do
          expect(current_path).to eq('/orders')
        end
      end

      context 'when they click in the Shopping cart menu' do
        before { within('body > nav') { click_on('Shopping Cart') } }

        scenario 'then they are taken to the shopping cart page' do
          expect(current_path).to eq('/shopping_cart_items')
        end
      end

      context 'when they click in the Log out menu' do
        before { within('body > nav') { click_on('Log out') } }

        scenario 'then they are kept in the home page but are informed that they logged out' do
          expect(current_path).to eq('/')
          expect(page).to have_text 'Signed out successfully.'
        end
      end
    end

    context 'given a guest user is accessing the home page' do
      before { visit '/' }

      scenario 'he or she can see the navigation menu bar with guest menus' do
        expect(find('body > nav')).to have_link('My Shopping Cart')
        expect(find('body > nav')).to have_link('Log in')
      end

      scenario 'he or she cannot see non guest menus' do
        expect(find('body > nav')).not_to have_link('Products')
        expect(find('body > nav')).not_to have_link('My Orders')
      end

      include_examples 'can see products in the page' do
        let(:products) { @products }
      end

      context 'when they click in the Shopping cart menu' do
        before { within('body > nav') { click_on('Shopping Cart') } }

        scenario 'then they are taken to the shopping cart page' do
          expect(current_path).to eq('/shopping_cart_items')
        end
      end

      context 'when they click in the Log in menu' do
        before { within('body > nav') { click_on('Log in') } }

        scenario 'then they are taken to the login screen' do
          expect(current_path).to eq('/users/sign_in')
        end
      end
    end
  end
end
