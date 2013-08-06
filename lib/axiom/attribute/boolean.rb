# encoding: utf-8

module Axiom
  class Attribute

    # Represents a Boolean value in a relation tuple
    class Boolean < Object
      include Function::Connective::Conjunction::Methods,
              Function::Connective::Disjunction::Methods,
              Function::Connective::Negation::Methods

      # The attribute type
      #
      # @example
      #   type = Axiom::Attribute::Boolean.type  # => Axiom::Types::Boolean
      #
      # @return [Class<Types::Boolean>]
      #
      # @api public
      def self.type
        Types::Boolean
      end

    end # class Boolean

    # Add aliases for Boolean
    TrueClass  = Boolean
    FalseClass = Boolean

  end # class Attribute
end # module Axiom
