module Veritas
  class Attribute
    class Boolean < Object
      def self.primitive
        TrueClass
      end

      def valid_value?(value)
        validate(value) { super || FalseClass === value }
      end
    end # class Boolean
  end # class Attribute
end # module Veritas
