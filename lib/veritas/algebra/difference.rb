module Veritas
  module Algebra
    class Difference < Relation
      include Relation::Operation::Set

      def each
        right_set = right.to_set
        left.each { |tuple| yield(tuple) unless right_set.include?(tuple) }
        self
      end

      def optimize
        left, right = optimize_left, optimize_right

        return new_empty_relation if left.eql?(right)

        if left.kind_of?(Relation::Empty) || right.kind_of?(Relation::Empty)
          left
        else
          super
        end
      end

    end # class Difference
  end # module Algebra
end # module Veritas
