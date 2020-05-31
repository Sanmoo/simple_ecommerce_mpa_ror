# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items

  validates_presence_of :delivery_address

  accepts_nested_attributes_for :order_items

  def total_price
    order_items.map(&:total_price).sum
  end
end
