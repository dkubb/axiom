module Veritas
  class Optimizer
    module Relation

      # Abstract base class representing Materialized optimizations
      class Materialized < Optimizer

        # Optimize when the operand is Empty
        class EmptyOperand < self

          # Test if the operand is empty
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            operation.empty?
          end

          # Return a new Empty relation with the operation's headers
          #
          # @return [Empty]
          #
          # @api private
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
