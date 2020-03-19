class PaymentInformation
  include ActiveModel::Model
  attr_accessor :credit_card_number, :holder_name, :expiration_date, :security_code

  validates_presence_of :credit_card_number, :holder_name, :expiration_date, :security_code
end