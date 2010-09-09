module Veritas
  class Optimizer
    module Algebra
      class Extension < Relation::Operation::Unary
        class UnoptimizedOperand < self
          def optimizable?
            !operand.equal?(operation.operand)
          end

          def optimize
            operation = self.operation
            operation.class.new(operand, operation.extensions)
          end

        end # class UnoptimizedOperand

        Veritas::Algebra::Extension.optimizer = chain(
          MaterializedOperand,
          UnoptimizedOperand
        )

      end # class Extension
    end # module Algebra
  end # class Optimizer
end # module Veritas
