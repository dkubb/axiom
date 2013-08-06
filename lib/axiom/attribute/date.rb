# encoding: utf-8

module Axiom
  class Attribute

    # Represents a Date value in a relation tuple
    class Date < Object
      include Comparable

      # The attribute type
      #
      # @example
      #   type = Axiom::Attribute::Date.type  # => Axiom::Types::Date
      #
      # @return [Class<Types::Date>]
      #
      # @api public
      def self.type
        Types::Date
      end

    end # class Date
  end # class Attribute
end # module Axiom
