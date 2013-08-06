# encoding: utf-8

module Axiom
  class Attribute

    # Represents an Object value in a relation tuple
    class Object < Attribute
      include Function::Predicate::Equality::Methods,
              Function::Predicate::Exclusion::Methods,
              Function::Predicate::Inequality::Methods,
              Function::Predicate::Inclusion::Methods,
              Aggregate::Count::Methods

      # The attribute type
      #
      # @example
      #   type = Axiom::Attribute::Object.type  # => Axiom::Types::Object
      #
      # @return [Class<Types::Object>]
      #
      # @api public
      def self.type
        Types::Object
      end

    end # class Object
  end # class Attribute
end # module Axiom
