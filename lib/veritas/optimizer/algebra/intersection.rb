module Veritas
  class Optimizer
    module Algebra
      class Intersection < Relation::Operation::Binary
        class EqualOperands < self
          include Relation::Operation::Binary::EqualOperands

          def optimize
            left
          end

        end # class EqualOperands

        class EmptyLeft < self
          include Relation::Operation::Binary::EmptyLeft

          def optimize
            left
          end

        end # class EmptyLeft

        class EmptyRight < self
          include Relation::Operation::Binary::EmptyRight

          def optimize
            right
          end

        end # class EmptyRight

        Veritas::Algebra::Intersection.optimizer = chain(
          EqualOperands,
          EmptyLeft,
          EmptyRight,
          MaterializedOperand,
          UnoptimizedOperand
        )

      end # class Intersection
    end # module Algebra
  end # class Optimizer
end # module Veritas
