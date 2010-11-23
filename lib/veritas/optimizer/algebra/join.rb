module Veritas
  class Optimizer
    module Algebra

      # Abstract base class representing Join optimizations
      class Join < Relation::Operation::Combination

        # Optimize when operand headers are equivalent
        class EqualHeaders < self

          # Test if the operands' headers are equal
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            left.header.eql?(right.header)
          end

          # A Join with equal headers is an Intersection
          #
          # @return [Algebra::Intersection]
          #
          # @api private
          def optimize
            Veritas::Algebra::Intersection.new(left, right)
          end

        end # class EqualHeaders

        Veritas::Algebra::Join.optimizer = chain(
          EmptyLeft,
          EmptyRight,
          EqualHeaders,
          MaterializedOperand,
          UnoptimizedOperand
        )

      end # class Join
    end # module Algebra
  end # class Optimizer
end # module Veritas
