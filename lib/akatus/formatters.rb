module Akatus

  NUMERIC_FIELDS =
    [
      :price, :weight, :shipping_cost, :discount, :amount
    ]

  INTEGER_FIELDS =
    [
      :quantity
    ]

  STRING_FIELDS =
    [
      :reference
    ]

  def self.format_number(val)
    ActiveSupport::NumberHelper.number_to_rounded(val, :locale => :en, :precision => 2)
  end

end
