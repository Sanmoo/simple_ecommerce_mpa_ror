# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :authenticate_user!
  include ShoppingCartConcern

  def new
    @order_form = OrderForm.new(order: Order.new, payment_information: PaymentInformation.new)
    build_shopping_cart_items_from_session.each do |sci|
      @order_form.order.order_items.build(
        product: sci.product,
        quantity: sci.quantity,
        unitary_price: sci.product.price
      )
    end
  end

  def create
    @order_form = OrderForm.new(order_form_params.to_h.deep_merge({ order_attributes: { user: current_user } }))
    if @order_form.save
      update_shopping_cart_items_in_session([])
      redirect_to home_show_url, notice: 'Checkout completed with success. You should soon receive your delivery.'
    else
      render :new
    end
  end

  private

  def order_form_params
    params.require(:order_form).permit(
      order_attributes: [:delivery_address, order_items_attributes: [:product_id, :unitary_price, :quantity]],
      payment_information_attributes: [:credit_card_number, :holder_name, :expiration_date, :security_code]
    )
  end
end