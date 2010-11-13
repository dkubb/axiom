module Veritas
  class Optimizer
    module Algebra

      # Abstract base class representing Extension optimizations
      class Extension < Relation::Operation::Unary

        # Optimize when operands are optimizable
        class UnoptimizedOperand < self

          # Test if the Extension has an unoptimized operand
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            !operand.equal?(operation.operand)
          end

          # Return an Extension with optimized operands
          #
          # @return [Algebra::Extension]
          #
          # @api private
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
