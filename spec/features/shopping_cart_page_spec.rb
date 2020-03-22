require 'rails_helper'

RSpec.feature 'Shopping cart page', type: :feature do
  context 'when a guest user visit the shopping cart page' do
    pending 'they cant see the checkout button'
    pending 'they cant see any products'
  end

  context 'given a guest user had previously added three products to their shopping cart' do
    context 'when they click in navbar "My Shopping Cart" button' do
      pending 'they can see their shopping cart information'
      pending 'they can see a checkout button'

      context 'when they click two times in +1 for ProductA' do
        pending 'the shopping cart total items and price are updated'
        pending 'the navbar total items is updated'

        context 'when they click one time in -1 for ProductA' do
          pending 'the shopping cart total items and price are updated'
          pending 'the navbar total items is updated'

          context 'when they click in Remove for ProductB' do
            pending 'the shopping cart total items and price are updated'
            pending 'the navbar total items is updated'

            context 'when they click in checkout button' do
              pending 'Then a message asking for login or sign up pops up'

              context 'when the user logs in and goes to the My Shopping Cart page again' do
                context 'when the user clicks in Checkout' do
                  pending 'Then they are taken to the checkout page'
                end
              end
            end
          end
        end
      end
    end
  end
end