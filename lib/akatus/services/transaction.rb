module Akatus

  module Services

    class Transaction < Akatus::Service

      PATH   = 'carrinho'
      METHOD = :post

      def self.form_url
        Akatus.config.base_url + PATH
      end

      def self.create(*args)
        self.new.create(*args)
      end

      def create(payment)

        @payment = payment

        data = send_request

        @payment.id             = data['carrinho']

        # TODO: improve; use constants?
        @payment.status         = data['status']
        @payment.transaction_id = data['transacao']

        if data['url_retorno']
          @payment.url = data['url_retorno'].sub("https://www.akatus.com/", Akatus.config.base_url)
        end

        @payment

      end

      def status
        # TODO: implement.
      end

      def to_payload
        @payment.to_payload
      end

    end

  end

end
