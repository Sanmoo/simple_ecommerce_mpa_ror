# frozen_string_literal: true

require 'features/shared/can_see_products'
require 'rails_helper'

RSpec.feature 'Admin home page', type: :feature do
  context 'given 4 products are registered' do
    before do
      @products = []
      4.times { @products.push(create(:product)) }
    end

    context 'given the admin user has just logged in' do
      before do
        @admin = create(:admin_user)
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
    end

    context 'given the customer user has just logged in' do
      before do
        @customer = create(:customer_user)
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
    end
  end
end
