# frozen_string_literal: true

module ShoppingCartConcern
  extend ActiveSupport::Concern

  private

  def build_shopping_cart_items_from_session
    (session[:product_ids_list] || '').split(',').reduce([]) do |memo, id|
      already_contained = memo.find { |it| it.product.id == id.to_i }
      if already_contained
        already_contained.quantity = already_contained.quantity + 1
        memo
      else
        p = Product.find(id.to_i)
        memo.push(ShoppingCartItem.new(product: p, quantity: 1))
      end
    end
  end

  def update_shopping_cart_items_in_session(shopping_cart_items)
    session[:product_ids_list] =
      shopping_cart_items
      .flat_map { |item| [item.product.id.to_s] * item.quantity }
      .join(',')
  end
end
