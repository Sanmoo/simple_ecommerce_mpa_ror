require 'rails_helper'

RSpec.feature 'Product details page', type: :feature do
  context 'given 3 products exist' do
    before do
      @products = create_list(:product, 3)
    end

    context 'given a customer user is logged in' do
      before do
        login_as create(:user)
      end

      context 'when they visit the details page for product A' do
        before do
          @current_product = @products[0]
          visit "/"
          click_on @current_product.name
        end
        
        scenario 'they can see the nav bar' do
          expect(page).to have_css('body > nav')
        end

        scenario 'they can see the product information' do
          expect(page).to have_text(@current_product.name)
          expect(page).to have_text(@current_product.description)
          expect(page).to have_text(@current_product.price)
        end

        scenario 'they can see action buttons for customers', js: true do
          expect(page).to have_link('Add to Cart')
          expect(page).to have_link('Back')
          expect(page).to have_link('My Shopping Cart (0)')
        end

        context 'when they click on Add to cart' do
          before { click_on 'Add to Cart' }

          scenario 'they can see a successful feedback message and their shopping cart is incremented by 1', js: true do
            expect(page).to have_text('Item successfully added to your cart')
            expect(page).to have_link('My Shopping Cart (1)')
          end

          scenario 'they are taken to the home page' do
            expect(current_path).to eq('/home/show')
          end

          context 'when they add product B to the cart' do
            before do
              @current_product = @products[1]
              visit "/products/#{@current_product.id}"
              click_on 'Add to Cart'
            end

            scenario 'they can see a successful feedback message and their shopping cart is incremented by 1', js: true do
              expect(page).to have_text('Item successfully added to your cart')
              expect(page).to have_link('My Shopping Cart (2)')
            end

            scenario 'they are taken to the home page' do
              expect(current_path).to eq('/home/show')
            end
          end
        end

        scenario 'they can go back to the previous page they were in', js: true do
          click_on 'Back'
          expect(current_path).to eq('/')
        end
      end
    end

    context 'given an admin user is logged in' do
      before { login_as create(:user, :admin) }

      context 'when they visit the details page for product A' do
        before do
          @current_product = @products[0]
          visit '/'
          click_on @current_product.name
        end

        scenario 'they can see the nav bar' do
          expect(page).to have_css('body > nav')
        end

        scenario 'they can see the product information' do
          expect(page).to have_text(@current_product.name)
          expect(page).to have_text(@current_product.description)
          expect(page).to have_text(@current_product.price)
        end

        scenario 'they can see action buttons for admins' do
          expect(page).to have_link('Edit')
          expect(page).to have_link('Back')
        end

        scenario 'they can edit that product information' do
          click_on 'Edit'
          expect(current_path).to eq("/products/#{@current_product.id}/edit")
        end

        scenario 'they can go back to the previous page they were in', js: true do
          click_on 'Back'
          expect(current_path).to eq('/')
        end
      end
    end
  end
end