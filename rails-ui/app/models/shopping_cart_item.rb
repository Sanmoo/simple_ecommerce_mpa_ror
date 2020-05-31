# frozen_string_literal: true

class ShoppingCartItem
  include ActiveModel::Model

  attr_accessor :product, :quantity
end
