module Akatus
  class Item
    include Transferrable
    transferrable_attrs :reference, :description, :quantity, :price, :weight,
                        :shipping_cost, :discount, :split_fee

    def initialize(opts = {})
      opts = {
        :shipping_cost => 0,
        :discount      => 0,
        :weight        => 0,
        :quantity      => 1
      }.merge(opts)
      super(opts)
    end

    def total_amount
      quantity * BigDecimal.new(price.to_s) +
        BigDecimal.new(shipping_cost.to_s) -
        BigDecimal.new(discount.to_s)
    end

  end
end
