module Veritas
  class Optimizer
    module Logic
      module Connective

        # Abstract base class representing Conjunction optimizations
        class Conjunction < Binary

          # Optimize when the left operand is true
          class TrueLeftOperand < self

            # Test if the left operand is true
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              left_true?
            end

            # A Conjunction with a true left operand is equivalent to the right
            #
            # @return [Expression]
            #
            # @api private
            def optimize
              right
            end

          end # class TrueLeftOperand

          # Optimize when the right operand is true
          class TrueRightOperand < self

            # Test if the right operand is true
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              right_true?
            end

            # A Conjunction with a true right operand is equivalent to the left
            #
            # @return [Expression]
            #
            # @api private
            def optimize
              left
            end

          end # class TrueRightOperand

          # Optimize when the operands are inequality predicates for the same attribute
          class OptimizableToExclusion < self

            # Test if the operands are inequality predicates for the same attribute
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              inequality_with_same_attributes?
            end

            # Return an Exclusion for an attribute against a set of values
            #
            # @return [Exclusion]
            #
            # @api private
            def optimize
              left = self.left
              Veritas::Logic::Predicate::Exclusion.new(left.left, [ left.right, right.right ]).optimize
            end

          end # class OptimizableToExclusion

          # Optimize when the operands are always false
          class AlwaysFalse < self

            # Test if the operands are always false
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              left_false?                    ||
              right_false?                   ||
              equality_with_same_attributes? ||
              left.inverse.eql?(right)
            end

            # Return false
            #
            # @return [False]
            #
            # @api private
            def optimize
              Veritas::Logic::Proposition::False.instance
            end

          end # class AlwaysFalse

          Veritas::Logic::Connective::Conjunction.optimizer = chain(
            TrueLeftOperand,
            TrueRightOperand,
            OptimizableToExclusion,
            EqualOperands,
            RedundantLeftOperand,
            RedundantRightOperand,
            AlwaysFalse,
            UnoptimizedOperand
          )

        end # class Conjunction
      end # module Connective
    end # module Logic
  end # class Optimizer
end # module Veritas
