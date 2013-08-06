# encoding: utf-8

module Axiom
  class Function

    # Abstract base class for logical predicates
    class Predicate < Function
      include AbstractType,
              Binary::Invertible,
              Binary,
              Connective::Conjunction::Methods,
              Connective::Disjunction::Methods,
              Connective::Negation::Methods

      # Return the type returned from #call
      #
      # @example
      #   type = Axiom::Function::Predicate.type  # => Axiom::Types::Boolean
      #
      # @return [Class<Types::Boolean>]
      #
      # @api public
      def self.type
        Types::Boolean
      end

    end # class Predicate
  end # class Function
end # module Axiom
