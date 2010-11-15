module Veritas
  class Optimizer
    module Relation
      module Operation

        # Abstract base class representing Unary relation optimizations
        class Unary < Optimizer

          # The optimized operand
          #
          # @return [Relation]
          #
          # @api private
          attr_reader :operand

          # Initialize a Unary optimizer
          #
          # @return [undefined]
          #
          # @api private
          def initialize(*)
            super
            @operand = optimize_operand
          end

        private

          # Optimize the operand
          #
          # @return [Relation]
          #
          # @api private
          def optimize_operand
            operation.operand.optimize
          end

          # Optimize when the operand is Empty
          class EmptyOperand < self

            # Test if the operand is empty
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              operand.kind_of?(Veritas::Relation::Empty)
            end

            # A Unary operation on an empty operand is empty
            #
            # @return [Relation::Empty]
            #
            # @api private
            def optimize
              operand
            end

          end # class EmptyOperand

          # Optimize when the operand is Materialized
          class MaterializedOperand < self

            # Test if the operand is materialized
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              operand.kind_of?(Veritas::Relation::Materialized)
            end

            # Return the materialized operation
            #
            # @return [Relation::Materialized]
            #
            # @api private
            def optimize
              operation.materialize
            end

          end # class MaterializedOperand
        end # class Unary
      end # module Operation
    end # module Relation
  end # class Optimizer
end # module Veritas
