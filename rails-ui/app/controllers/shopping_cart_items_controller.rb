# frozen_string_literal: true

class ShoppingCartItemsController < ApplicationController
  include ShoppingCartConcern

  def create
    if session[:product_ids_list].blank?
      session[:product_ids_list] = params[:product_id].to_s
    else
      session[:product_ids_list] += ",#{params[:product_id]}"
    end
    flash[:notice] = 'Item successfully added to your cart'
    redirect_to home_show_path
  end

  def index
    @shopping_cart_items = build_shopping_cart_items_from_session
  end

  def update
    @shopping_cart_items = build_shopping_cart_items_from_session
    shopping_cart_item = @shopping_cart_items.find { |it| it.product.id == params[:product_id].to_i }
    return render status: 404 unless shopping_cart_item

    new_quantity = shopping_cart_item.quantity + params[:increase].to_i
    if new_quantity != 0
      shopping_cart_item.quantity = new_quantity
      update_shopping_cart_items_in_session(@shopping_cart_items)
      return head 204
    end
    @shopping_cart_items = @shopping_cart_items
                           .filter { |item| item.product.id.to_s != params[:product_id] }
    update_shopping_cart_items_in_session(@shopping_cart_items)
    head 204
  end

  def delete
    @shopping_cart_items =
      build_shopping_cart_items_from_session
      .filter { |item| item.product.id.to_s != params[:product_id] }
    update_shopping_cart_items_in_session(@shopping_cart_items)
    head 204
  end

end
