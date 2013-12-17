module Akatus
  class Phone
    include Transferrable
    transferrable_attrs :type, :number
  end
end
