class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates_presence_of :quantity, :unitary_price, :product

  def total_price
    unitary_price * quantity
  end
end
