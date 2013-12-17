module Akatus
  class Receiver
    include Transferrable
    transferrable_attrs :email, :api_key
  end
end
