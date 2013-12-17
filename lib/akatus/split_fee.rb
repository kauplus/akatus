module Akatus
  class SplitFee
    include Transferrable
    transferrable_attrs :receiver, :type, :amount
  end
end
