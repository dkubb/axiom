# encoding: utf-8

module Axiom
  class Attribute

    # Represents a Decimal value in a relation tuple
    class Decimal < Numeric

      # The Decimal primitive
      #
      # @example
      #   Decimal.primitive  # => BigDecimal
      #
      # @return [Class<BigDecimal>]
      #
      # @api public
      def self.primitive
        BigDecimal
      end

    end # class Decimal
  end # class Attribute
end # module Axiom
