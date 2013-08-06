# encoding: utf-8

module Axiom
  class Attribute

    # Represents an Integer value in a relation tuple
    class Integer < Numeric

      # The attribute type
      #
      # @example
      #   type = Axiom::Attribute::Integer.type  # => Axiom::Types::Integer
      #
      # @return [Class<Types::Integer>]
      #
      # @api public
      def self.type
        Types::Integer
      end

    end # class Integer
  end # class Attribute
end # module Axiom
