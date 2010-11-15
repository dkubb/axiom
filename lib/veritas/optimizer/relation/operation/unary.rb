module Veritas
  class Optimizer
    module Relation
      module Operation
        class Unary < Optimizer
          attr_reader :operand

          def initialize(*)
            super
            @operand = optimize_operand
          end

        private

          def optimize_operand
            operation.operand.optimize
          end

          class EmptyOperand < self
            def optimizable?
              operand.kind_of?(Veritas::Relation::Empty)
            end

            def optimize
              operand
            end

          end # class EmptyOperand

          class MaterializedOperand < self
            def optimizable?
              operand.kind_of?(Veritas::Relation::Materialized)
            end

            def optimize
              operation.materialize
            end

          end # class MaterializedOperand
        end # class Unary
      end # module Operation
    end # module Relation
  end # class Optimizer
end # module Veritas
