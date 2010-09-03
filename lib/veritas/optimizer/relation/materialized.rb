module Veritas
  class Optimizer
    module Relation
      class Materialized < Optimizer
        class EmptyOperand < self
          def optimizable?
            operation.empty?
          end

          def optimize
            Veritas::Relation::Empty.new(operation.header)
          end

        end # class EmptyOperand

        Veritas::Relation::Materialized.optimizer = chain(
          EmptyOperand
        )

      end # class Materialized
    end # module Relation
  end # class Optimizer
end # module Veritas
