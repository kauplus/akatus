module Akatus
  class InstallmentOptions
    include Transferrable
    attr_accessor :description, :installments, :taken_installments

    #
    # Build an empty ("dummy") object.
    #
    def self.blank(payment)

      # The only "option" is to pay the full amount in one installment.
      installment_options = [
        Installment.new({
            :quantity       => 1,
            :unitary_amount => payment.total_amount,
            :total_amount   => payment.total_amount
        })
      ]

      new({ :taken_installments => 0, :installments => installment_options })
    end

  end
end
