module Veritas
  class Optimizer
    module Algebra
      class Summarization < Relation::Operation::Unary
        class UnoptimizedOperand < self
          def optimizable?
            !operand.equal?(operation.operand)
          end

          def optimize
            operation = self.operation
            operation.class.new(operand, operation.summarize_by, operation.summarizers)
          end

        end # class UnoptimizedOperand

        Veritas::Algebra::Summarization.optimizer = chain(
          MaterializedOperand,
          UnoptimizedOperand
        )

      end # class Summarization
    end # module Algebra
  end # class Optimizer
end # module Veritas
