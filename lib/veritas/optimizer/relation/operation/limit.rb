module Veritas
  class Optimizer
    module Relation
      module Operation
        class Limit < Unary

        private

          def limit
            operation.to_i
          end

          class ZeroLimit < self
            def optimizable?
              limit.zero?
            end

            def optimize
              Veritas::Relation::Empty.new(operation.header)
            end

          end # class ZeroLimit

          class EqualLimitOperand < self
            def optimizable?
              operand.kind_of?(operation.class) && equal_limit?
            end

            def optimize
              operand
            end

          private

            def equal_limit?
              limit == operand.to_i
            end

          end # class EqualLimitOperand

          class InequalLimitOperand < self
            def optimizable?
              operand.kind_of?(operation.class) && inequal_limit?
            end

            def optimize
              operation.class.new(operand.operand, min_limit)
            end

          private

            def inequal_limit?
              limit != operand.to_i
            end

            def min_limit
              [ limit, operand.to_i ].min
            end

          end # class InequalLimitOperand

          class UnoptimizedOperand < self
            def optimizable?
              !operand.equal?(operation.operand)
            end

            def optimize
              operation.class.new(operand, limit)
            end

          end # class UnoptimizedOperand

          Veritas::Relation::Operation::Limit.optimizer = chain(
            ZeroLimit,
            EqualLimitOperand,
            InequalLimitOperand,
            EmptyOperand,
            MaterializedOperand,
            UnoptimizedOperand
          )

        end # class Limit
      end # module Operation
    end # module Relation
  end # class Optimizer
end # module Veritas
