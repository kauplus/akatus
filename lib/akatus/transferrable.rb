module Akatus

  module Transferrable

    def self.included(klass)
      klass.send(:extend, ClassMethods)
    end

    def initialize(attrs = {})
      attrs.each { |attr, val| send("#{attr}=", val) }
    end

    def to_payload(include_root = true)
      class_key = self.class.name.demodulize.underscore

      payload = Hash[(self.class.attributes || []).map do |attr|

        attr_value = send(attr)

        next if attr_value.nil?

        if attr_value.respond_to?(:to_payload)
          attr_value = attr_value.to_payload(false)
        end

        if NUMERIC_FIELDS.include?(attr)
          attr_value = Akatus.format_number(attr_value)
        end

        if (INTEGER_FIELDS + STRING_FIELDS).include?(attr)
          attr_value = attr_value.to_s
        end

        [ I18n.t(attr, :locale => "pt-BR", :scope => [:payload, :attributes, class_key]), attr_value ]
      end]

      if include_root
        { I18n.t(class_key, :locale => "pt-BR", :scope => [:payload]) => payload }
      else
        payload
      end

    end

    module ClassMethods
      def attributes
        @attributes
      end

      def transferrable_attrs(*args)
        @attributes = *args
        attr_accessor(*args)
      end
    end

  end

end
