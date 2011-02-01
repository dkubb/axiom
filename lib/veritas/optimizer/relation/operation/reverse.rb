module Veritas
  class Optimizer
    module Relation
      module Operation

        # Abstract base class representing Reverse optimizations
        class Reverse < Order

          # Optimize when the operand is a Reverse
          class ReverseOperand < self

            # Test if the operand is a Reverse
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              operand.kind_of?(operation.class)
            end

            # A Reverse of a Reverse is a noop
            #
            # @return [Relation]
            #
            # @api private
            def optimize
              operand.operand
            end

          end # class ReverseOperand

          # Optimize when the operand is an Order
          class OrderOperand < self

            # Test if the operand is an Order
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              operand.kind_of?(Veritas::Relation::Operation::Order)
            end

            # Flatten Reverse operation and Order operand into an Order
            #
            # @return [Order]
            #
            # @api private
            def optimize
              operand = self.operand
              operand.class.new(operand.operand, operation.directions).optimize
            end

          end # class OrderOperand

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

            # Return an Reverse with an optimized operand
            #
            # @return [Reverse]
            #
            # @api private
            def optimize
              operation.class.new(operand).optimize
            end

          end # class UnoptimizedOperand

          Veritas::Relation::Operation::Reverse.optimizer = chain(
            ReverseOperand,
            OrderOperand,
            OneLimitOperand,
            EmptyOperand,
            MaterializedOperand,
            UnoptimizedOperand
          )

        end # class Reverse
      end # module Operation
    end # module Relation
  end # class Optimizer
end # module Veritas
