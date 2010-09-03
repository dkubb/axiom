module Veritas
  class Optimizer
    module Relation
      module Operation
        class Unary < Optimizer
          attr_reader :operand

          def initialize(*)
            super
            @operand = operation.operand.optimize
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

            # TODO: add Relation#materialize and change to use it
            def optimize
              operation = self.operation
              Veritas::Relation::Materialized.new(operation.header, operation.to_a)
            end

          end # class MaterializedOperand
        end # class Unary
      end # module Operation
    end # module Relation
  end # class Optimizer
end # module Veritas
