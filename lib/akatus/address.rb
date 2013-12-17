module Akatus

  class Address
    include Transferrable
    transferrable_attrs :type, :street, :number, :neighborhood,
                        :additional_details, :city, :state, :country, :postal_code

    attr_accessor :reference
  end

end
