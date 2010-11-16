module Veritas
  class Optimizer
    module Logic
      module Connective

        # Abstract base class representing Disjunction optimizations
        class Disjunction < Binary

          # Optimize when the left operand is false
          class FalseLeftOperand < self

            # Test if the left operand is false
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              left_false?
            end

            # A Disjunction with a false left operand is equivalent to the right
            #
            # @return [Expression]
            #
            # @api private
            def optimize
              right
            end

          end # class FalseLeftOperand

          # Optimize when the right operand is false
          class FalseRightOperand < self

            # Test if the right operand is false
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              right_false?
            end

            # A Disjunction with a false right operand is equivalent to the left
            #
            # @return [Expression]
            #
            # @api private
            def optimize
              left
            end

          end # class FalseRightOperand

          # Optimize when the operands are equality predicates for the same attribute
          class OptimizableToInclusion < self

            # Test if the operands are equality predicates for the same attribute
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              equality_with_same_attributes?
            end

            # Return an Inclusion for an attribute having a set of values
            #
            # @return [Inclusion]
            #
            # @api private
            def optimize
              left = self.left
              Veritas::Logic::Predicate::Inclusion.new(left.left, [ left.right, right.right ]).optimize
            end

          end # class OptimizableToInclusion

          # Optimize when the operands are always true
          class AlwaysTrue < self

            # Test if the operands are always true
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              left_true?                       ||
              right_true?                      ||
              inequality_with_same_attributes? ||
              left.inverse.eql?(right)
            end

            # Return true
            #
            # @return [True]
            #
            # @api private
            def optimize
              Veritas::Logic::Proposition::True.instance
            end

          end # class AlwaysTrue

          Veritas::Logic::Connective::Disjunction.optimizer = chain(
            FalseLeftOperand,
            FalseRightOperand,
            OptimizableToInclusion,
            EqualOperands,
            RedundantLeftOperand,
            RedundantRightOperand,
            AlwaysTrue,
            UnoptimizedOperand
          )

        end # class Disjunction
      end # module Connective
    end # module Logic
  end # class Optimizer
end # module Veritas
