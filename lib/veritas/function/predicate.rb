module Veritas
  class Function

    # Abstract base class for logical predicates
    class Predicate < Function
      include AbstractClass, Binary
    end # class Predicate
  end # class Function
end # module Veritas
