module Akatus

  module Services

    class Installments < Akatus::Service

      PATH   = 'parcelamento/simulacao'
      METHOD = :get

      def self.calculate(payment)
        self.new.calculate(payment)
      end

      def calculate(payment)

        @payment = payment

        unless payment.payment_method.is_a?(CreditCard)
          return InstallmentOptions.blank(payment)
        end

        data = send_request

        options = InstallmentOptions.new

        options.description        = data['descricao']
        options.taken_installments = data['parcelas_assumidas']

        options.installments = data['parcelas'].map do |parcela|
          Installment.new({
            :quantity       => parcela['quantidade'],
            :unitary_amount => BigDecimal.new(parcela['valor']),
            :total_amount   => BigDecimal.new(parcela['total'])
          })
        end

        options

      end

      def to_payload
        {
          :email          => @payment.receiver.email,
          :amount         => @payment.total_amount,
          :payment_method => @payment.payment_method.brand,
          :api_key        => @payment.receiver.api_key
        }
      end

    end

  end

end
