module Veritas
  class Optimizer
    module Algebra

      # Abstract base class representing Difference optimizations
      class Difference < Relation::Operation::Binary

        # Optimize when operands are equal in a Difference
        class EqualOperands < self
          include Relation::Operation::Binary::EqualOperands

          # A Difference with equal operands is empty
          #
          # @return [Relation::Empty]
          #
          # @api private
          def optimize
            Veritas::Relation::Empty.new(operation.header)
          end

        end # class EqualOperands

        # Optimize when the left operand is empty in a Difference
        class EmptyLeft < self
          include Relation::Operation::Binary::EmptyLeft

          # A Difference with an empty left operand is empty
          #
          # @return [Relation::Empty]
          #
          # @api private
          def optimize
            left
          end

        end # class EmptyLeft

        # Optimize when the right operand is empty in a Difference
        class EmptyRight < self
          include Relation::Operation::Binary::EmptyRight

          # A Difference with an empty right operand is equivalent to the left
          #
          # @return [Relation]
          #
          # @api private
          def optimize
            left
          end

        end # class EmptyRight

        Veritas::Algebra::Difference.optimizer = chain(
          EqualOperands,
          EmptyLeft,
          EmptyRight,
          MaterializedOperand,
          UnoptimizedOperand
        )

      end # class Difference
    end # module Algebra
  end # class Optimizer
end # module Veritas
