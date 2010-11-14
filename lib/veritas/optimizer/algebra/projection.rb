module Veritas
  class Optimizer
    module Algebra

      # Abstract base class representing Projection optimizations
      class Projection < Relation::Operation::Unary

        # The projected header
        #
        # @return [Header]
        #
        # @api private
        attr_reader :header

        # Initialize an Projection optimizer
        #
        # @return [undefined]
        #
        # @api private
        def initialize(*)
          super
          @header = operation.header
        end

        # Optimize when the headers are not changed
        class UnchangedHeader < self

          # Test if the projected headers are the same as the operand's
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            header.to_a == operand.header.to_a
          end

          # A Projection with unchanged headers is a noop
          #
          # @return [Relation]
          #
          # @api private
          def optimize
            operand
          end

        end # class UnchangedHeader

        # Optimize when the operand is a Projection
        class ProjectionOperand < self

          # Test if the operand is a Projection
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            operand.kind_of?(operation.class)
          end

          # Flatten nested Projections into a single Projection
          #
          # @return [Projection]
          #
          # @api private
          def optimize
            operation.class.new(operand.operand, header)
          end

        end # class ProjectionOperand

        # Optimize when the operand is a Set
        class SetOperand < self

          # Test if the operand is a Set
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            operand.kind_of?(Veritas::Relation::Operation::Set)
          end

          # Wrap each operand in the Set in a Projection
          #
          # @return [Set]
          #
          # @api private
          def optimize
            operand.class.new(wrap_left, wrap_right).optimize
          end

        private

          # Utility method to wrap the left operand in a Projection
          #
          # @return [Projection]
          #
          # @api private
          def wrap_left
            operation.class.new(operand.left, header)
          end

          # Utility method to wrap the right operand in a Projection
          #
          # @return [Projection]
          #
          # @api private
          def wrap_right
            operation.class.new(operand.right, header)
          end

        end # class SetOperand

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

          # Return a new Empty relation with the operation's headers
          #
          # @return [Empty]
          #
          # @api private
          def optimize
            Veritas::Relation::Empty.new(header)
          end

        end # class EmptyOperand

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

          # Return a Projection with an optimized operand
          #
          # @return [Projection]
          #
          # @api private
          def optimize
            operation.class.new(operand, header)
          end

        end # class UnoptimizedOperand

        Veritas::Algebra::Projection.optimizer = chain(
          UnchangedHeader,
          ProjectionOperand,
          SetOperand,
          EmptyOperand,
          MaterializedOperand,
          UnoptimizedOperand
        )

      end # class Projection
    end # module Algebra
  end # class Optimizer
end # module Veritas
