# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Admin home page', type: :feature do
  scenario 'Not logged in users see warning and are asked to log in' do
    visit '/'

    query = 'body > .container > div:first-child'
    expect(page).to have_css(query)
    expect(find(query).text).to have_text('You need to sign in or sign up before continuing')

    query = 'input[type=email][name="user[email]"]'
    expect(page).to have_css(query)

    query = 'input[type=password][name="user[password]"]'
    expect(page).to have_css(query)
  end

  context 'when the user is logged in' do
    before do
      @admin = create(:user)
      login_as @admin
    end

    scenario 'User can see the navigation bar' do
      visit '/'

      query = 'body > nav'
      expect(page).to have_css(query)
      expect(find(query).text).to have_text('Simple Ecommerce RoR MPA')
      expect(find(query).text).to have_text('Products')
    end
  end
end
