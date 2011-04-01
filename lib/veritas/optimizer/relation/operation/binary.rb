module Veritas
  class Optimizer
    module Relation
      module Operation

        # Abstract base class representing Binary relation optimizations
        class Binary < Optimizer

          # The optimized left operand
          #
          # @return [Relation]
          #
          # @api private
          attr_reader :left

          # The optimized right operand
          #
          # @return [Relation]
          #
          # @api private
          attr_reader :right

          # Initialize an Binary optimizer
          #
          # @return [undefined]
          #
          # @api private
          def initialize(*)
            super
            @left  = optimize_left
            @right = optimize_right
          end

        private

          # Optimize the left operand
          #
          # @return [Relation]
          #
          # @api private
          def optimize_left
            operation.left.optimize
          end

          # Optimize the right operand
          #
          # @return [Relation]
          #
          # @api private
          def optimize_right
            operation.right.optimize
          end

          # Optimize when operands are equal
          module EqualOperands

            # Test if the operands are equal
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              left.eql?(right)
            end

          end # module EqualOperands

          # Optimize when the left operand is Empty
          module EmptyLeft

            # Test if the left operand is empty
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              left.kind_of?(Veritas::Relation::Empty)
            end

          end # module EmptyLeft

          # Optimize when the right operand is Empty
          module EmptyRight

            # Test if the right operand is empty
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              right.kind_of?(Veritas::Relation::Empty)
            end

          end # module EmptyRight

          # Optimize when the operands are Materialized
          class MaterializedOperand < self

            # Test if the operands are materialized
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              left.kind_of?(Veritas::Relation::Materialized) &&
              right.kind_of?(Veritas::Relation::Materialized)
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

          # Optimize when the operands are unoptimized
          class UnoptimizedOperand < self

            # Test if the operands are unoptimized
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              left_optimizable? || right_optimizable?
            end

            # Return a Relation with optimized operands
            #
            # @return [Relation]
            #
            # @api private
            def optimize
              operation.class.new(left, right)
            end

          private

            # Test if the left operand is optimizable
            #
            # @return [Boolean]
            #
            # @api private
            def left_optimizable?
              !left.equal?(operation.left)
            end

            # Test if the right operand is optimizable
            #
            # @return [Boolean]
            #
            # @api private
            def right_optimizable?
              !right.equal?(operation.right)
            end

          end # class UnoptimizedOperand
        end # class Binary
      end # module Operation
    end # module Relation
  end # class Optimizer
end # module Veritas
