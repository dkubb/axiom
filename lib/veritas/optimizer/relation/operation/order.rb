module Veritas
  class Optimizer
    module Relation
      module Operation

        # Abstract base class representing Order optimizations
        class Order < Unary

          # Optimize when the operand is an Order
          class OrderOperand < self

            # Test if the operand is an Order
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              operand.kind_of?(operation.class)
            end

            # Flatten Order operations using the operation directions
            #
            # @return [Order]
            #
            # @api private
            def optimize
              operation = self.operation
              operation.class.new(operand.operand, operation.directions)
            end

          end # class OrderOperand

          # Optimize when the operand is a Limit with a limit of 1
          class OneLimitOperand < self

            # Test if the operand is an Limit with a limit of 1
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              operand = self.operand
              operand.kind_of?(Veritas::Relation::Operation::Limit) &&
              operand.limit == 1
            end

            # An Order of a Limit with a limit of 1 is a noop
            #
            # @return [Limit]
            #
            # @api private
            def optimize
              operand
            end

          end # class OneLimitOperand

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

            # Return an Order with an optimized operand
            #
            # @return [Offset]
            #
            # @api private
            def optimize
              operation = self.operation
              operation.class.new(operand, operation.directions)
            end

          end # class UnoptimizedOperand

          Veritas::Relation::Operation::Order.optimizer = chain(
            OrderOperand,
            OneLimitOperand,
            EmptyOperand,
            MaterializedOperand,
            UnoptimizedOperand
          )

        end # class Order
      end # module Operation
    end # module Relation
  end # class Optimizer
end # module Veritas
