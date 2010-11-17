module Veritas
  class Optimizer
    module Logic
      class Predicate

        # Abstract base class representing Enumerable predicate optimizations
        module Enumerable

        private

          # Optimize the right operand
          #
          # @return [Object]
          #
          # @api private
          def optimize_right
            right = operation.right

            if right.respond_to?(:to_inclusive)
              optimize_right_range
            elsif right.respond_to?(:select)
              optimize_right_enumerable
            else
              right
            end
          end

          # Optimize the right range operand
          #
          # @return [Range]
          #
          # @api private
          def optimize_right_range
            right = operation.right
            right.to_inclusive if right.overlaps?(left.range)
          end

          # Optimize the right enumerable operand
          #
          # @return [Enumerable]
          #
          # @api private
          def optimize_right_enumerable
            enumerable = normalized_right_enumerable
            right      = operation.right

            right.eql?(enumerable) ? right : enumerable
          end

          # Normalize the right enumerable to only include unique, sorted, valid values
          #
          # @return [Enumerable]
          #
          # @api private
          def normalized_right_enumerable
            enumerable = operation.right.select { |value| left.valid_value?(value) }
            enumerable.sort!
            enumerable.uniq!
            enumerable
          end

          # Optimize when the right operand is empty
          module EmptyRightOperand
            include Enumerable

            # Test if the right operand is empty
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              right_nil? || right_none?
            end

          private

            # Test if the right operand is nil
            #
            # @return [Boolean]
            #
            # @api private
            def right_nil?
              right.nil?
            end

            # Test if the right operand has no entries
            #
            # @return [Boolean]
            #
            # @api private
            def right_none?
              right.none? { true }
            end

          end # module EmptyRightOperand

          # Optimize when the right operand has one entry
          module OneRightOperand
            include Enumerable

            # Test if the right operand has one entry
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              right.one? { true }
            end

          end # module OneRightOperand

          # Optimize when the operands are unoptimized
          class UnoptimizedOperand < Predicate
            include Enumerable

            # Test if the operands are unoptimized
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              !right.equal?(operation.right)
            end

            # Return a Enumerable predicate with optimized operands
            #
            # @return [Binary]
            #
            # @api private
            def optimize
              operation.class.new(left, right)
            end

          end # class UnoptimizedOperand
        end # module Enumerable
      end # class Predicate
    end # module Logic
  end # class Optimizer
end # module Veritas
