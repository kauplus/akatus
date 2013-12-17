module Akatus

  class PaymentType
    include Transferrable
    attr_accessor :type
  end

  class CreditCard < PaymentType
    transferrable_attrs :brand, :number, :security_code, :installments, :expiration

    attr_accessor :holder_name, :holder_cpf, :holder_phone

    def to_payload
      payload = super
      payload['cartao_de_credito']['portador'] = {
        :nome     => holder_name,
        :cpf      => holder_cpf,
        :telefone => holder_phone
      }
      payload['cartao_de_credito']
    end
  end

  class ElectronicFundsTransfer < PaymentType
    transferrable_attrs :brand
    def to_payload
      { :meio_de_pagamento => brand }
    end
  end

  class BoletoBancario < PaymentType
    attr_accessor :brand
    def to_payload
      { :meio_de_pagamento => 'boleto' }
    end
  end
end