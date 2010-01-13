module Veritas
  module Algebra
    class Union
      class Body < Relation::Body
        include BinaryOperation

        def each
          seen = {}
          @left.each  { |tuple| yield(seen[tuple] = tuple)           }
          @right.each { |tuple| yield(tuple) unless seen.key?(tuple) }
          self
        end

      end # class Body
    end # class Union
  end # module Algebra
end # module Veritas
