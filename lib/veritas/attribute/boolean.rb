module Veritas
  class Attribute
    class Boolean < Object
      include Logic::Connective::Methods

      def self.primitive
        TrueClass
      end

      def valid_value?(value)
        valid_or_optional?(value) { super || value.kind_of?(FalseClass) }
      end

    end # class Boolean
  end # class Attribute
end # module Veritas
