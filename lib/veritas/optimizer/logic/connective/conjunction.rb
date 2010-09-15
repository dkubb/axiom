module Veritas
  class Optimizer
    module Logic
      module Connective
        class Conjunction < Binary
          class TrueLeftOperand < self
            def optimizable?
              left_true?
            end

            def optimize
              right
            end

          end # class TrueLeftOperand

          class TrueRightOperand < self
            def optimizable?
              right_true?
            end

            def optimize
              left
            end

          end # class TrueRightOperand

          class OptimizableToExclusion < self
            def optimizable?
              inequality_with_same_attributes?
            end

            def optimize
              left = self.left
              Veritas::Logic::Predicate::Exclusion.new(left.left, [ left.right, right.right ]).optimize
            end

          end # class OptimizableToExclusion

          class AlwaysFalse < self
            def optimizable?
              left_false?                    ||
              right_false?                   ||
              equality_with_same_attributes? ||
              left.inverse.eql?(right)
            end

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
