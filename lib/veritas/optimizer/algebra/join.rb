module Veritas
  class Optimizer
    module Algebra
      class Join < Relation::Operation::Combine

        Veritas::Algebra::Join.optimizer = chain(
          EmptyLeft,
          EmptyRight,
          MaterializedOperand,
          UnoptimizedOperand
        )

      end # class Join
    end # module Algebra
  end # class Optimizer
end # module Veritas
