# frozen_string_literal: true

class HomeController < ApplicationController
  def show
    @products = Product.all
  end
end
