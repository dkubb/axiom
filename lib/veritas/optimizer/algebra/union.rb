module Veritas
  class Optimizer
    module Algebra
      class Union < Relation::Operation::Binary
        class EqualOperands < self
          include Relation::Operation::Binary::EqualOperands

          def optimize
            left
          end

        end # class EqualOperands

        class EmptyLeft < self
          include Relation::Operation::Binary::EmptyLeft

          def optimize
            right
          end

        end # class EmptyLeft

        class EmptyRight < self
          include Relation::Operation::Binary::EmptyRight

          def optimize
            left
          end

        end # class EmptyRight

        Veritas::Algebra::Union.optimizer = chain(
          EqualOperands,
          EmptyRight,
          EmptyLeft,
          MaterializedOperand,
          UnoptimizedOperand
        )

      end # class Union
    end # module Algebra
  end # class Optimizer
end # module Veritas
