module Akatus
  class Installment
    include Transferrable
    attr_accessor :quantity, :unitary_amount, :total_amount
  end
end
