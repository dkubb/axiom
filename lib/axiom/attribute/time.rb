# encoding: utf-8

module Axiom
  class Attribute

    # Represents a Time value in a relation tuple
    class Time < Object
      include ValueComparable

      # The attribute type
      #
      # @example
      #   type = Axiom::Attribute::Time.type  # => Axiom::Types::Time
      #
      # @return [Class<Types::Time>]
      #
      # @api public
      def self.type
        Types::Time
      end

    end # class Time
  end # class Attribute
end # module Axiom
