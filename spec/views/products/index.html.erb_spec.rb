# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'products/index', type: :view do
  before(:each) do
    assign(:products, [
             Product.create!(
               name: 'Product 1',
               description: 'MyText',
               price: '9.99',
               quantity_in_stock: 2
             ),
             Product.create!(
               name: 'Product 2',
               description: 'MyText',
               price: '9.99',
               quantity_in_stock: 2
             )
           ])
  end

  it 'renders a list of products' do
    render
    assert_select 'tr>td', text: 'Product 1'.to_s, count: 1
    assert_select 'tr>td', text: 'Product 2'.to_s, count: 1
    assert_select 'tr>td', text: '9.99'.to_s, count: 2
    assert_select 'tr>td', text: 2.to_s, count: 2
  end
end
