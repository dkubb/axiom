module Veritas
  class Optimizer
    module Logic
      module Connective

        # Abstract base class representing Binary connective optimizations
        class Binary < Optimizer

          # The optimized left operand
          #
          # @return [Expression]
          #
          # @api private
          attr_reader :left

          # The optimized right operand
          #
          # @return [Expression]
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
          # @return [Expression]
          #
          # @api private
          def optimize_left
            # TODO: move Predicate.optimize_operand to a better location
            Predicate.optimize_operand(operation.left)
          end

          # Optimize the right operand
          #
          # @return [Expression]
          #
          # @api private
          def optimize_right
            # TODO: move Predicate.optimize_operand to a better location
            Predicate.optimize_operand(operation.right)
          end

          # Test if the operands are equality predicates for the same attribute
          #
          # @return [Boolean]
          #
          # @api private
          def equality_with_same_attributes?
            left.kind_of?(Veritas::Logic::Predicate::Equality)  &&
            right.kind_of?(Veritas::Logic::Predicate::Equality) &&
            same_attribute?                                     &&
            constant_value?
          end

          # Test if the operands are inequality predicates for the same attribute
          #
          # @return [Boolean]
          #
          # @api private
          def inequality_with_same_attributes?
            left.kind_of?(Veritas::Logic::Predicate::Inequality)  &&
            right.kind_of?(Veritas::Logic::Predicate::Inequality) &&
            same_attribute?                                       &&
            constant_value?
          end

          # Test if the left and right predicates are for the same attribute
          #
          # @return [Boolean]
          #
          # @api private
          def same_attribute?
            left.left.equal?(right.left)
          end

          # Test if the left and right predicates match against constant values
          #
          # @return [Boolean]
          #
          # @api private
          def constant_value?
            util = Predicate::Util
            util.constant?(left.right) && util.constant?(right.right)
          end

          # Test if the left is true
          #
          # @return [Boolean]
          #
          # @api private
          def left_true?
            left.equal?(Veritas::Logic::Proposition::True.instance)
          end

          # Test if the right is true
          #
          # @return [Boolean]
          #
          # @api private
          def right_true?
            right.equal?(Veritas::Logic::Proposition::True.instance)
          end

          # Test if the left is false
          #
          # @return [Boolean]
          #
          # @api private
          def left_false?
            left.equal?(Veritas::Logic::Proposition::False.instance)
          end

          # Test if the right is false
          #
          # @return [Boolean]
          #
          # @api private
          def right_false?
            right.equal?(Veritas::Logic::Proposition::False.instance)
          end

          # Optimize when the operands are equal
          class EqualOperands < self

            # Test if the operands are equal
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              left.eql?(right)
            end

            # A Binary connective with equal operands is equivalent to the left
            #
            # @return [Expression]
            #
            # @api private
            def optimize
              left
            end

          end # class EqualOperands

          # Optimize when the left operand is redundant
          class RedundantLeftOperand < self

            # Test if the left operand is redundant
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              left = self.left
              operation.kind_of?(left.class) && right.eql?(left.right)
            end

            # A Binary connective with a redundant left operand is equivalent to the left
            #
            # @return [Expression]
            #
            # @api private
            def optimize
              left
            end

          end # class RedundantLeftOperand

          # Optimize when the right operand is redundant
          class RedundantRightOperand < self

            # Test if the right operand is redundant
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              right = self.right
              operation.kind_of?(right.class) && left.eql?(right.left)
            end

            # A Binary connective with a redundant right operand is equivalent to the right
            #
            # @return [Expression]
            #
            # @api private
            def optimize
              right
            end

          end # class RedundantRightOperand

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

            # Return a Binary connective with optimized operands
            #
            # @return [Binary]
            #
            # @api private
            def optimize
              operation.class.new(left, right).optimize
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
      end # module Connective
    end # module Logic
  end # class Optimizer
end # module Veritas
