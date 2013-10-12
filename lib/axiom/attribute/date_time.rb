# encoding: utf-8

module Axiom
  class Attribute

    # Represents a DateTime value in a relation tuple
    class DateTime < Object
      include ValueComparable

      # The attribute type
      #
      # @example
      #   type = Axiom::Attribute::DateTime.type  # => Axiom::Types::DateTime
      #
      # @return [Class<Types::DateTime>]
      #
      # @api public
      def self.type
        Types::DateTime
      end

    end # class DateTime
  end # class Attribute
end # module Axiom
