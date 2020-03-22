require 'rails_helper'

RSpec.feature 'Product details page', type: :feature do
  context 'given 3 products exist' do
    context 'given a customer user is logged in' do
      context 'when they visit the details page for product A' do
        pending 'they can see the nav bar'
        pending 'they can see the product information'
        pending 'they can see action buttons for customers'

        context 'when they click on Add to cart' do
          pending 'they can see a successful feedback message and their shopping cart is incremented by 1'
          pending 'they are taken to the home page'

          context 'when they add product B to the cart' do
            pending 'they can see a successful feedback message and their shopping cart is incremented by 1'
            pending 'they are taken to the home page'
          end
        end

        pending 'they can go back to the previous page they were in'
      end
    end

    context 'given an admin user is logged in' do
      context 'when they visit the details page for product A' do
        pending 'they can see the nav bar'
        pending 'they can see the product information'
        pending 'they can see action buttons for admins'
        pending 'they can edit that product information'
        pending 'they can go back to the previous page they were in'
      end
    end
  end
end