module Veritas
  class Optimizer
    module Relation
      module Operation
        class Order < Unary
          class OrderOperand < self
            def optimizable?
              operand.kind_of?(operation.class)
            end

            def optimize
              operation = self.operation
              operation.class.new(operand.operand, operation.directions)
            end

          end # class OrderOperand

          class OneLimitOperand < self
            def optimizable?
              operand = self.operand
              operand.kind_of?(Veritas::Relation::Operation::Limit) &&
              operand.to_i == 1
            end

            def optimize
              operand
            end

          end # class OneLimitOperand

          class UnoptimizedOperand < self
            def optimizable?
              !operand.equal?(operation.operand)
            end

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
