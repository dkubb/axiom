module Veritas
  class Attribute

    # Represents a Decimal value in a relation tuple
    class Decimal < Numeric

      # The Decimal primitive
      #
      # @example
      #   Decimal.primitive  # => BigDecimal
      #
      # @return [BigDecimal]
      #
      # @api public
      def self.primitive
        BigDecimal
      end

    end # class Decimal
  end # class Attribute
end # module Veritas
