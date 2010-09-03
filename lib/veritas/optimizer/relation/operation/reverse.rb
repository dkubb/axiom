module Veritas
  class Optimizer
    module Relation
      module Operation
        class Reverse < Order
          class ReverseOperand < self
            def optimizable?
              operand.kind_of?(operation.class)
            end

            def optimize
              operand.operand
            end

          end # class ReverseOperand

          class OrderOperand < self
            def optimizable?
              operand.kind_of?(Veritas::Relation::Operation::Order)
            end

            def optimize
              operand = self.operand
              operand.class.new(operand.operand, operation.directions)
            end

          end # class OrderOperand

          class UnoptimizedOperand < self
            def optimizable?
              !operand.equal?(operation.operand)
            end

            def optimize
              operation.class.new(operand)
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
