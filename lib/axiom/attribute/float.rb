# encoding: utf-8

module Axiom
  class Attribute

    # Represents a Float value in a relation tuple
    class Float < Numeric

      # The attribute type
      #
      # @example
      #   type = Axiom::Attribute::Float.type  # => Axiom::Types::Float
      #
      # @return [Class<Types::Float>]
      #
      # @api public
      def self.type
        Types::Float
      end

    end # class Float
  end # class Attribute
end # module Axiom
