# frozen_string_literal: true

# Wraps the result from calling a business method
class CallResult
  attr_accessor :result, :errors

  def initialize(result = nil, errors = nil)
    self.result = result
    self.errors = errors
  end

  def successful?
    errors.nil? || errors.empty?
  end
end