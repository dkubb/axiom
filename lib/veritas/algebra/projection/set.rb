module Veritas
  module Algebra
    class Projection
      class Set
        def initialize(tuples, header)
          @tuples, @header = tuples, header
        end

        def each
          seen = {}
          @tuples.each do |tuple|
            tuple = tuple.project(@header)
            yield(seen[tuple] = tuple) unless seen.key?(tuple)
          end
          self
        end

      end # class Set
    end # class Projection
  end # module Algebra
end # module Veritas
