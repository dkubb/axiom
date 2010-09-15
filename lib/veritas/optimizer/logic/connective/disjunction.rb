module Veritas
  class Optimizer
    module Logic
      module Connective
        class Disjunction < Binary
          class FalseLeftOperand < self
            def optimizable?
              left_false?
            end

            def optimize
              right
            end

          end # class FalseLeftOperand

          class FalseRightOperand < self
            def optimizable?
              right_false?
            end

            def optimize
              left
            end

          end # class FalseRightOperand

          class OptimizableToInclusion < self
            def optimizable?
              equality_with_same_attributes?
            end

            def optimize
              left = self.left
              Veritas::Logic::Predicate::Inclusion.new(left.left, [ left.right, right.right ]).optimize
            end

          end # class OptimizableToInclusion

          class AlwaysTrue < self
            def optimizable?
              left_true?                       ||
              right_true?                      ||
              inequality_with_same_attributes? ||
              left.inverse.eql?(right)
            end

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
