module Akatus
  class Payer
    include Transferrable
    transferrable_attrs :name, :email

    attr_accessor :addresses, :phones

    def address=(val)
      addresses ? addresses.unshift(val) : (@addresses = [val])
    end

    def address
      addresses[0] if addresses
    end

    def phone=(val)
      phones ? phones.unshift(val) : (@phones = [val])
    end

    def phone
      phones[0] if phones
    end

    def to_payload(include_root = true)
      payload = super(true)

      # Tweak Akatus' weird array format.
      payload['pagador']['enderecos'] = { 'endereco' => addresses.map { |a| a.to_payload(false) } }
      payload['pagador']['telefones'] = { 'telefone' => phones.map { |p| p.to_payload(false) } }

      include_root ? payload : payload.values.first
    end

  end
end
