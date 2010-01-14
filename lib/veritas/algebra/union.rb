module Veritas
  module Algebra
    class Union < Relation
      include Relation::Operation::Set

      def each
        seen = {}
        left.each  { |tuple| yield(seen[tuple] = tuple)           }
        right.each { |tuple| yield(tuple) unless seen.key?(tuple) }
        self
      end

    end # class Union
  end # module Algebra
end # module Veritas
