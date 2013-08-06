# encoding: utf-8

module Axiom
  class Attribute

    # Represents a Decimal value in a relation tuple
    class Decimal < Numeric

      # The attribute type
      #
      # @example
      #   type = Axiom::Attribute::Decimal.type  # => Axiom::Types::Decimal
      #
      # @return [Class<Types::Decimal>]
      #
      # @api public
      def self.type
        Types::Decimal
      end

    end # class Decimal
  end # class Attribute
end # module Axiom
