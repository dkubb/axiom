# encoding: utf-8

module Veritas
  class Function

    # Abstract base class for logical predicates
    class Predicate < Function
      include AbstractClass,
              Binary::Invertible,
              Binary,
              Connective::Conjunction::Methods,
              Connective::Disjunction::Methods,
              Connective::Negation::Methods

      # Return the type returned from #call
      #
      # @return [Class<Attribute::Boolean>]
      #
      # @api public
      def type
        Attribute::Boolean
      end

    end # class Predicate
  end # class Function
end # module Veritas
