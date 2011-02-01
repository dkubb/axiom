module Veritas
  class Optimizer
    module Algebra

      # Abstract base class representing Summarization optimizations
      class Summarization < Relation::Operation::Unary

        # Optimize when operand is optimizable
        class UnoptimizedOperand < self

          # Test if the operand is unoptimized
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            !operand.equal?(operation.operand)
          end

          # Return a Summarization with an optimized operand
          #
          # @return [Rename]
          #
          # @api private
          def optimize
            operation = self.operation
            operation.class.new(operand, operation.summarize_by, operation.summarizers).optimize
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
