# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_shopping_cart_items_quantity

  private

  def set_shopping_cart_items_quantity
    @shopping_cart_quantity = (session[:product_ids_list] || '').split(',').size
  end
end
