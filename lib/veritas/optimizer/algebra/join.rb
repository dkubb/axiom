module Veritas
  class Optimizer
    module Algebra
      class Join < Relation::Operation::Combine
        class EqualHeaders < self
          def optimizable?
            left.header == right.header
          end

          def optimize
            Veritas::Algebra::Intersection.new(left, right)
          end

        end

        Veritas::Algebra::Join.optimizer = chain(
          EmptyLeft,
          EmptyRight,
          EqualHeaders,
          MaterializedOperand,
          UnoptimizedOperand
        )

      end # class Join
    end # module Algebra
  end # class Optimizer
end # module Veritas
