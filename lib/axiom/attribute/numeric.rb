# encoding: utf-8

module Axiom
  class Attribute

    # Represents a Numeric value in a relation tuple
    class Numeric < Object
      include ValueComparable,
              Aggregate::Sum::Methods

      # The attribute type
      #
      # @example
      #   type = Axiom::Attribute::Numeric.type  # => Axiom::Types::Numeric
      #
      # @return [Class<Types::Numeric>]
      #
      # @api public
      def self.type
        Types::Numeric
      end

    end # class Numeric
  end # class Attribute
end # module Axiom
