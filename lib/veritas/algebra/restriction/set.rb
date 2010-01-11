module Veritas
  module Algebra
    class Restriction
      class Set
        def initialize(tuples, predicate)
          @tuples, @predicate = tuples, predicate
        end

        def each
          @tuples.each { |tuple| yield(tuple) if @predicate.call(tuple) }
          self
        end

      end # class Set
    end # class Restriction
  end # module Algebra
end # module Veritas
