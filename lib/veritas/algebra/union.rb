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
        left, right = self.left.optimize, self.right.optimize

        if left.kind_of?(Relation::Empty)
          left
        elsif right.kind_of?(Relation::Empty)
          right
        else
          super
        end
      end

    end # class Union
  end # module Algebra
end # module Veritas
