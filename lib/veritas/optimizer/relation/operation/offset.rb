module Veritas
  class Optimizer
    module Relation
      module Operation
        class Offset < Unary

        private

          def offset
            operation.to_i
          end

          class ZeroOffset < self
            def optimizable?
              offset.zero?
            end

            def optimize
              operand
            end

          end # class ZeroOffset

          class OffsetOperand < self
            def optimizable?
              operand.kind_of?(operation.class)
            end

            def optimize
              operation.class.new(operand.operand, sum_offset)
            end

          private

            def sum_offset
              offset + operand.to_i
            end

          end # class OffsetOperand

          class UnoptimizedOperand < self
            def optimizable?
              !operand.equal?(operation.operand)
            end

            def optimize
              operation.class.new(operand, offset)
            end

          end # class UnoptimizedOperand

          Veritas::Relation::Operation::Offset.optimizer = chain(
            ZeroOffset,
            OffsetOperand,
            EmptyOperand,
            MaterializedOperand,
            UnoptimizedOperand
          )

        end # class Offset
      end # module Operation
    end # module Relation
  end # class Optimizer
end # module Veritas
