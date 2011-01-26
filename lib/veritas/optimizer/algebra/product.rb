module Veritas
  class Optimizer
    module Algebra

      # Abstract base class representing Product optimizations
      class Product < Relation::Operation::Combination

        # Optimize when left operand is a TABLE DEE
        class TableDeeLeft < self

          # Test if the left operand is a TABLE DEE
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            left = self.left
            left.header.empty? && !left.kind_of?(Veritas::Relation::Empty)
          end

          # A Product with a left TABLE DEE is equivalent to the right operand
          #
          # @return [Relation]
          #
          # @api private
          def optimize
            right
          end

        end # class TableDeeLeft

        # Optimize when right operand is a TABLE DEE
        class TableDeeRight < self

          # Test if the right operand is a TABLE DEE
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            right = self.right
            right.header.empty? && !right.kind_of?(Veritas::Relation::Empty)
          end

          # A Product with a right TABLE DEE is equivalent to the left operand
          #
          # @return [Relation]
          #
          # @api private
          def optimize
            left
          end

        end # class TableDeeRight

        Veritas::Algebra::Product.optimizer = chain(
          TableDeeLeft,
          TableDeeRight,
          EmptyLeft,
          EmptyRight,
          MaterializedOperand,
          UnoptimizedOperand
        )

      end # class Product
    end # module Algebra
  end # class Optimizer
end # module Veritas
