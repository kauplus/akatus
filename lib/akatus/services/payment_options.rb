# encoding: utf-8

module Akatus

  module Services

    class PaymentOptions < Akatus::Service

      PATH   = 'meios-de-pagamento'
      METHOD = :post

      def self.available
        self.new.available
      end

      def self.available_with_installments(*args)
        self.new.available_with_installments(*args)
      end

      def available
        data    = send_request
        result  = {}

        data['meios_de_pagamento'].each do |payment_type|

          key = payment_description_to_type(payment_type['descricao'])

          options = payment_type['bandeiras'].map do |payment_option|
            PaymentOption.new({
              :code         => payment_option['codigo'],
              :description  => payment_option['descricao'],
              :installments => payment_option['parcelas']
            })
          end

          result[key] = {
            :name    => payment_type['descricao'],
            :options => options
          }

        end

        result
      end

      def available_with_installments(transaction)

        result = available()

        result.each do |type, group|
          group[:options].each do |option|
            transaction.payment_method = payment_type_to_class(type).new({ :brand => option.code })
            option.installments = Installments.calculate(transaction)
          end
        end

        result

      end

      def payment_description_to_type(group)
        case group
        when 'Boleto Bancário'   then :boleto
        when 'Cartão de Crédito' then :credit_card
        when 'TEF'               then :eft
        else raise "Unknown payment group: #{group}"
        end
      end

      def payment_type_to_class(type)
        case type
        when :boleto      then Akatus::BoletoBancario
        when :credit_card then Akatus::CreditCard
        when :eft         then Akatus::ElectronicFundsTransfer
        else raise "Unknown payment group: #{group}"
        end
      end


      def to_payload
        {
          :meios_de_pagamento => {
            :correntista => {
              :email   => Akatus.config.email,
              :api_key => Akatus.config.api_key
            }
          }
        }
      end

    end

  end

end
