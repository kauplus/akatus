module Akatus
  class Payment
    include Transferrable

    attr_reader   :receiver

    attr_accessor :reference, :payer, :items, :payment_method,
                  :weight, :shipping_cost, :discount, :currency,
                  :id, :status, :transaction_id, :url, :error, :total_amount

    def initialize(opts = {})
      options = {
        :items         => [],
        :discount      => 0,
        :shipping_cost => 0,
        :weight        => 0
      }.merge(opts)
      super(options)

      @receiver = Receiver.new({ :email => Akatus.config.email, :api_key => Akatus.config.api_key })
    end

    def to_payload
      hsh = {
        'carrinho' => {
          'produtos'  => { 'produto' => items.map { |i| i.to_payload(false) } },
          'transacao' => {
            'peso'       => Akatus.format_number(total_weight),
            'frete'      => Akatus.format_number(total_shipping_cost),
            'desconto'   => Akatus.format_number(total_discount),
            'referencia' => reference,
            'moeda'      => 'BRL'
          }.merge(payment_method.to_payload),
          'recebedor'  => receiver.to_payload(false),
          'pagador'    => payer.to_payload(false)
        }
      }
    end

    def total_weight
      weight + items.inject(0) { |sum, item| sum + item.weight }
    end

    def total_shipping_cost
      shipping_cost + items.inject(0) { |sum, item| sum + item.shipping_cost }
    end

    def total_discount
      discount + items.inject(0) { |sum, item| sum + item.discount }
    end

    def total_items_amount
      items.inject(0) { |sum, item| sum + item.total_amount }
    end

    def total_amount
      total_items_amount - total_discount + total_shipping_cost
    end

  end
end
