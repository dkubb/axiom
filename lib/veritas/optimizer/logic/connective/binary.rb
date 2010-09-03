module Veritas
  class Optimizer
    module Logic
      module Connective
        class Binary < Optimizer
          attr_reader :left, :right

          def initialize(*)
            super
            @left  = optimize_left
            @right = optimize_right
          end

        private

          def optimize_left
            # TODO: move Predicate.optimize_operand to a better location
            Predicate.optimize_operand(operation.left)
          end

          def optimize_right
            # TODO: move Predicate.optimize_operand to a better location
            Predicate.optimize_operand(operation.right)
          end

          def equality_with_same_attributes?
            left.kind_of?(Veritas::Logic::Predicate::Equality)  &&
            right.kind_of?(Veritas::Logic::Predicate::Equality) &&
            same_attribute?                                     &&
            constant_value?
          end

          def inequality_with_same_attributes?
            left.kind_of?(Veritas::Logic::Predicate::Inequality)  &&
            right.kind_of?(Veritas::Logic::Predicate::Inequality) &&
            same_attribute?                                       &&
            constant_value?
          end

          def same_attribute?
            left.left.equal?(right.left)
          end

          def constant_value?
            util = Predicate::Util
            util.constant?(left.right) && util.constant?(right.right)
          end

          def left_true?
            left.equal?(Veritas::Logic::Proposition::True.instance)
          end

          def right_true?
            right.equal?(Veritas::Logic::Proposition::True.instance)
          end

          def left_false?
            left.equal?(Veritas::Logic::Proposition::False.instance)
          end

          def right_false?
            right.equal?(Veritas::Logic::Proposition::False.instance)
          end

          class EqualOperands < self
            def optimizable?
              left.eql?(right)
            end

            def optimize
              left
            end

          end # class EqualOperands

          class RedundantLeftOperand < self
            def optimizable?
              left = self.left
              operation.kind_of?(left.class) && right.eql?(left.right)
            end

            def optimize
              left
            end

          end # class RedundantLeftOperand

          class RedundantRightOperand < self
            def optimizable?
              right = self.right
              operation.kind_of?(right.class) && left.eql?(right.left)
            end

            def optimize
              right
            end

          end # class RedundantRightOperand

          class UnoptimizedOperand < self
            def optimizable?
              left_optimizable? || right_optimizable?
            end

            def optimize
              operation.class.new(left, right)
            end

          private

            def left_optimizable?
              !left.equal?(operation.left)
            end

            def right_optimizable?
              !right.equal?(operation.right)
            end

          end # class UnoptimizedOperand
        end # class Binary
      end # module Connective
    end # module Logic
  end # class Optimizer
end # module Veritas
