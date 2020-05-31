class OrderForm
  include ActiveModel::Model
  attr_accessor :order, :payment_information

  def order_attributes=(attributes)
    @order = Order.new(attributes)
  end

  def payment_information_attributes=(attributes)
    @payment_information = PaymentInformation.new(attributes)
  end

  def save
    valid? && order.save
  end

  def valid?
    valid_order = order.valid?
    valid_payment_info = payment_information.valid?
    valid_order && valid_payment_info
  end
end