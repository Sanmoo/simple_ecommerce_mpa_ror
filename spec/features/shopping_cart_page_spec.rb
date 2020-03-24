require 'rails_helper'

RSpec.feature 'Shopping cart page', type: :feature do
  context 'when a guest user visit the shopping cart page' do
    before do
      visit '/'
      click_on 'My Shopping Cart'
    end

    scenario 'they cant see the checkout button', js: true do
      expect(page).not_to have_button('Continue')
      expect(page).to have_text('Order summary')
    end
  end

  context 'given a guest user had previously added three products to their shopping cart', js: true do
    before do
      @products = create_list(:product, 3)
      @products.each do |product|
        visit '/'
        click_on product.name
        click_on 'Add to Cart'
      end
    end

    context 'when they click in navbar "My Shopping Cart" button' do
      before { click_on 'My Shopping Cart' }

      scenario 'they can see their shopping cart information' do
        @products.each_with_index do |product, index|
          within :xpath, "//table//tbody/tr[#{index + 1}]" do
            within :xpath, './td[1]' do
              expect(page).to have_text(product.name)
            end
            within :xpath, './td[2]' do
              expect(page).to have_button('-')
              expect(page).to have_button('+')
              expect(page).to have_button('Remove')
              expect(page).to have_text('1')
            end
            within :xpath, './td[3]' do
              expect(page).to have_text("$ #{product.price}")
            end
          end
        end

        expect(page).to have_text('Order summary') 
        expect(page).to have_text('Total: (3 products)') 
        expect(page).to have_text("$ #{@products.map(&:price).sum}") 
      end

      scenario 'they can see a checkout button' do
        expect(page).to have_button('Continue')
      end

      context 'when they click two times in +1 for ProductA' do
        before do
          within :xpath, "//table//tbody/tr[1]/td[2]" do
            2.times { click_on '+' }
          end
        end

        scenario 'the shopping cart total items and price are updated' do
          expect(page).to have_text('Order summary')
          expect(page).to have_text('Total: (5 products)') 
          expect(page).to have_text("$ #{@products.map(&:price).sum + @products[0].price * 2}") 
        end

        scenario 'the navbar total items is updated' do
          within :xpath, "//a[contains(text(), 'My Shopping Cart (')]" do
            expect(page).to have_text('My Shopping Cart (5)')
          end
        end

        context 'when they click one time in -1 for ProductA' do
          before do
            within :xpath, "//table//tbody/tr[1]/td[2]" do
              click_on '-'
            end
          end

          scenario 'the shopping cart total items and price are updated' do
            expect(page).to have_text('Order summary')
            expect(page).to have_text('Total: (4 products)')
            total = @products.map(&:price).sum + @products[0].price
            expect(page).to have_text("$ #{"%g" % ("%.2f" % total)}")
          end

          scenario 'the navbar total items is updated' do
            within :xpath, "//a[contains(text(), 'My Shopping Cart (')]" do
              expect(page).to have_text('My Shopping Cart (4)')
            end
          end

          context 'when they click in Remove for ProductB' do
            before do
              within :xpath, "//table//tbody/tr[2]/td[2]" do
                click_on 'Remove'
              end
            end

            scenario 'the shopping cart total items and price are updated' do
              expect(page).to have_text('Total: (3 products)')
              expect(page).to have_text("$ #{@products[0].price * 2 + @products[2].price}")
            end

            scenario 'the navbar total items is updated' do
              within :xpath, "//a[contains(text(), 'My Shopping Cart (')]" do
                expect(page).to have_text('My Shopping Cart (3)')
              end
            end

            context 'when they click in checkout button' do
              before { click_on 'Continue' }

              scenario 'Then a message asking for login or sign up pops up' do
                expect(page).to have_text('In order to proceed with checkout, you need first to signup. Or rather sign in if you are already a registered user.')
              end

              context 'when the user logs in and goes to the My Shopping Cart page again' do
                before do
                  click_on 'sign in'
                  user = create(:user)
                  fill_in 'user_email', with: user.email
                  fill_in 'user_password', with: user.password
                  click_on 'Log in'
                  click_on 'My Shopping Cart'
                end

                context 'when the user clicks in Checkout' do
                  before { click_on 'Continue' }

                  scenario 'Then they are taken to the checkout page' do
                    expect(current_path).to eq('/orders/new')
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end