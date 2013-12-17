module Akatus
  class PaymentOption
    include Transferrable
    attr_accessor :code, :description, :installments
  end
end
