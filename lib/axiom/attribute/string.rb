# encoding: utf-8

module Axiom
  class Attribute

    # Represents a String value in a relation tuple
    class String < Object
      include LengthComparable,
              Function::Predicate::Match::Methods,
              Function::Predicate::NoMatch::Methods

      # The attribute type
      #
      # @example
      #   type = Axiom::Attribute::String.type  # => Axiom::Types::String
      #
      # @return [Class<Types::String>]
      #
      # @api public
      def self.type
        Types::String
      end

    end # class String
  end # class Attribute
end # module Axiom
