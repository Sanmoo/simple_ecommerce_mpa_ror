require 'rails_helper'

RSpec.feature 'Login page', type: :feature do
  scenario 'redirects to home page if customer user is logged in' do
    login_as create(:user)
    visit 'users/sign_in'
    expect(current_path).to eq('/')
  end

  scenario 'redirects to home page if admin user is logged in' do
    login_as create(:user, :admin)
    visit 'users/sign_in'
    expect(current_path).to eq('/')
  end

  context 'given a guest user visits the login page' do
    before { visit 'users/sign_in' }

    scenario 'can see login form fields' do
      expect(page).to have_field('user_email')
      expect(page).to have_field('user_password')
      expect(page).to have_field('user_remember_me')
      expect(page).to have_button('Log in')
      expect(page).to have_link('Forgot your password?')
    end

    context 'when the user clicks in Forgot your password button' do
      before do
        click_on 'Forgot your password?'
      end

      scenario 'then he or she is taken to the forgot password screen' do
        expect(current_path).to eq('/users/password/new')
      end
    end

    context 'given the guest user is already registered as a customer' do
      let(:user) { create(:user) }

      context 'when he or she fills the form and click submit' do
        before do
          fill_in 'user_email', with: user.email
          fill_in 'user_password', with: user.password
          click_button 'Log in'
        end

        scenario 'then he or she is taken to the home page' do
          expect(current_path).to eq('/')
        end
      end
    end

    context 'given an admin user is registered' do
      let(:user) { create(:user, :admin) }

      context 'when he or she fills the form and click submit' do
        before do
          fill_in 'user_email', with: user.email
          fill_in 'user_password', with: user.password
          click_button 'Log in'
        end

        scenario 'then he or she is taken to the home page' do
          expect(current_path).to eq('/')
        end
      end
    end

    context 'when user fills the form incorrectly and click submit' do
      before do
        fill_in 'user_email', with: 'nonexistent@test.com'
        fill_in 'user_password', with: 'whatever'
        click_button 'Log in'
      end

      scenario 'then the page does not change and errors are rendered' do
        expect(current_path).to eq('/users/sign_in')
        expect(page).to have_xpath('//*[contains(text(), "Invalid Email or password.")]')
      end
    end
  end
end