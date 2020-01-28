# frozen_string_literal: true

class ShoppingCartItemsController < ApplicationController
  def create
    if session[:product_ids_list]
      session[:product_ids_list] += ",#{params[:product_id]}"
    else
      session[:product_ids_list] = params[:product_id].to_s
    end
    flash[:notice] = 'Item successfully added to your cart'
    redirect_to home_show_path
  end
end
