module Veritas
  module Algebra
    class Union
      class Set
        def initialize(left, right)
          @left, @right = left, right
        end

        def each
          seen = {}
          @left.each  { |tuple| yield(seen[tuple] = tuple)           }
          @right.each { |tuple| yield(tuple) unless seen.key?(tuple) }
          self
        end

      end # class Set
    end # class Union
  end # module Algebra
end # module Veritas
