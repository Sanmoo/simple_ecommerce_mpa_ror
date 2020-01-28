# frozen_string_literal: true

class HomeController < ApplicationController
  def show
    @products = Product.where('quantity_in_stock > 0')
  end
end
