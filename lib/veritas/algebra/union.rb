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

      def optimize
        left, right = optimize_left, optimize_right

        if left.kind_of?(Relation::Empty)
          right
        elsif right.kind_of?(Relation::Empty)
          left
        else
          super
        end
      end

    end # class Union
  end # module Algebra
end # module Veritas
