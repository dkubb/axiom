module Veritas
  module Algebra
    class Projection
      class Body < Relation::Body
        def each
          seen = {}
          @tuples.each do |tuple|
            tuple = tuple.project(@header)
            yield(seen[tuple] = tuple) unless seen.key?(tuple)
          end
          self
        end

      end # class Body
    end # class Projection
  end # module Algebra
end # module Veritas
