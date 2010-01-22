module Veritas
  module Algebra
    class Intersection < Relation
      include Relation::Operation::Set

      def each
        right_set = right.to_set
        left.each { |tuple| yield(tuple) if right_set.include?(tuple) }
        self
      end

      def optimize
        left, right = optimize_left, optimize_right

        if left.kind_of?(Relation::Empty)
          left
        elsif right.kind_of?(Relation::Empty)
          right
        else
          super
        end
      end

    end # class Intersection
  end # module Algebra
end # module Veritas
