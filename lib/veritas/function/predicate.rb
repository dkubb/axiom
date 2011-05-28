# encoding: utf-8

module Veritas
  class Function

    # Abstract base class for logical predicates
    class Predicate < Function
      include AbstractClass,
              Binary,
              Connective::Conjunction::Methods,
              Connective::Disjunction::Methods,
              Connective::Negation::Methods

    end # class Predicate
  end # class Function
end # module Veritas
