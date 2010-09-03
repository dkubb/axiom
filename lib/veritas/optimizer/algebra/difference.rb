module Veritas
  class Optimizer
    module Algebra
      class Difference < Relation::Operation::Binary
        class EqualOperands < self
          include Relation::Operation::Binary::EqualOperands

          def optimize
            Veritas::Relation::Empty.new(operation.header)
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
            left
          end

        end # class EmptyRight

        Veritas::Algebra::Difference.optimizer = chain(
          EqualOperands,
          EmptyLeft,
          EmptyRight,
          MaterializedOperand,
          UnoptimizedOperand
        )

      end # class Difference
    end # module Algebra
  end # class Optimizer
end # module Veritas
