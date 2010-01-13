module Veritas
  module Algebra
    class Restriction
      class Body < Relation::Body
        def initialize(tuples, predicate)
          @predicate = predicate
          super(tuples, tuples.header)
        end

        def each
          @tuples.each { |tuple| yield(tuple) if @predicate.call(tuple) }
          self
        end

      end # class Body
    end # class Restriction
  end # module Algebra
end # module Veritas
