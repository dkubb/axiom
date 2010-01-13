module Veritas
  module Algebra
    class Restriction
      class Body < Relation::Body
        def initialize(tuples, predicate)
          @tuples, @predicate = tuples, predicate
        end

        def each
          @tuples.each { |tuple| yield(tuple) if @predicate.call(tuple) }
          self
        end

      end # class Body
    end # class Restriction
  end # module Algebra
end # module Veritas
