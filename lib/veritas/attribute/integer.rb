module Veritas
  class Attribute

    # Represents an Integer value in a relation tuple
    class Integer < Numeric

      # The Integer primitive
      #
      # @example
      #   Integer.primitive  # => ::Integer
      #
      # @return [::Integer]
      #
      # @api public
      def self.primitive
        ::Integer
      end

    end # class Integer
  end # class Attribute
end # module Veritas
