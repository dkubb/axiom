module Veritas
  class Attribute

    # Represents a Boolean value in a relation tuple
    class Boolean < Object
      include Logic::Connective::Methods

      # The Boolean primitive
      #
      # @example
      #   Boolean.primitive  # => TrueClass
      #
      # @return [TrueClass]
      #
      # @api public
      def self.primitive
        TrueClass
      end

      # Test if the value is a boolean
      #
      # @example
      #   boolean.valid_value?(value)  # => true or false
      #
      # @param [Object] value
      #   the value to test
      #
      # @return [Boolean]
      #
      # @api public
      def valid_value?(value)
        valid_or_optional?(value) { super || value.kind_of?(FalseClass) }
      end

    end # class Boolean
  end # class Attribute
end # module Veritas
