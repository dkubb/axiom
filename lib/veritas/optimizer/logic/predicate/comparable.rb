module Veritas
  class Optimizer
    module Logic
      class Predicate

        # Abstract base class representing Comparable predicate optimizations
        module Comparable

          # Optimize when the operands can be normalized
          class NormalizableOperands < Predicate

            # Test if the operands can be normalized
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              util = Util
              util.constant?(left) && util.attribute?(right)
            end

            # Normalize the predicate by reversing the operands
            #
            # @return [Predicate]
            #
            # @api private
            def optimize
              operation.class.reverse.new(right, left)
            end

          end # class NormalizableOperands

          # Optimize when the operands will never be equivalent
          module NeverEquivalent

            # Test if the operands will never be equivalent
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              util = Util
              if    util.constant?(left)  then left_invalid_constant?
              elsif util.constant?(right) then right_invalid_constant?
              else
                not_joinable?
              end
            end

          private

            # Test if the left operand is an invalid constant
            #
            # @return [Boolean]
            #
            # @api private
            def left_invalid_constant?
              !right.valid_value?(left)
            end

            # Test if the right operand is an invalid constant
            #
            # @return [Boolean]
            #
            # @api private
            def right_invalid_constant?
              !left.valid_value?(right)
            end

            # Test if the left and right operand are not joinable
            #
            # @return [Boolean]
            #
            # @api private
            def not_joinable?
              !left.joinable?(right)
            end

          end # module NeverEquivalent

          # Optimize when the operands will never be comparable
          module NeverComparable

            # Test if the operands will never be comparable
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              util = Util
              if    util.constant?(left)  then left_invalid_constant?
              elsif util.constant?(right) then right_invalid_constant?
              else
                not_comparable?
              end
            end

          private

            # Test if the left operand is an invalid constant
            #
            # @return [Boolean]
            #
            # @api private
            def left_invalid_constant?
              !right.valid_primitive?(left)
            end

            # Test if the right operand is an invalid constant
            #
            # @return [Boolean]
            #
            # @api private
            def right_invalid_constant?
              !left.valid_primitive?(right)
            end

            # Test if the left and right operand are not comparable
            #
            # @return [Boolean]
            #
            # @api private
            def not_comparable?
              !left.comparable?(right)
            end

          end # module NeverComparable
        end # module Comparable
      end # class Predicate
    end # module Logic
  end # class Optimizer
end # module Veritas
