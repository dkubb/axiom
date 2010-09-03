module Veritas
  class Optimizer
    module Logic
      class Predicate
        module Enumerable

        private

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

          def optimize_right_range
            right = operation.right
            right.to_inclusive if right.overlaps?(left.range)
          end

          def optimize_right_enumerable
            right = operation.right
            # TODO: consider a data structure that makes matching, sorting
            # uniquing of large enumerables more efficient.
            enumerable = right.select { |value| left.valid_value?(value) }
            enumerable.sort!
            enumerable.uniq!
            right.eql?(enumerable) ? right : enumerable
          end

          module EmptyRightOperand
            include Enumerable

            def optimizable?
              right_nil? || right_none?
            end

          private

            def right_nil?
              right.nil?
            end

            def right_none?
              right.none? { true }
            end

          end # module EmptyRightOperand

          module OneRightOperand
            include Enumerable

            def optimizable?
              right.one? { true }
            end

          end # module OneRightOperand

          class UnoptimizedOperand < Predicate
            include Enumerable

            def optimizable?
              !right.equal?(operation.right)
            end

            def optimize
              operation.class.new(left, right)
            end

          end # class UnoptimizedOperand
        end # module Enumerable
      end # class Predicate
    end # module Logic
  end # class Optimizer
end # module Veritas
