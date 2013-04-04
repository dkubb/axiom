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

      # The Object primitive
      #
      # @example
      #   Object.primitive  # => ::Object
      #
      # @return [Class<::Object>]
      #
      # @api public
      def self.primitive
        ::Object
      end

    end # class Object
  end # class Attribute
end # module Axiom
