# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate_user!
  include ShoppingCartConcern

  def new
    @order = Order.new
    build_shopping_cart_items_from_session.each do |sci|
      @order.order_items.build(product: sci.product, quantity: sci.quantity, unitary_price: sci.product.price)
    end
  end
end
