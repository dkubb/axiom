module Veritas
  class Optimizer
    module Logic
      class Predicate
        module Comparable
          class NormalizableOperands < Predicate
            def optimizable?
              util = Util
              util.constant?(left) && util.attribute?(right)
            end

            def optimize
              operation.class.reverse.new(right, left)
            end

          end # class NormalizableOperands

          module NeverEquivalent
            def optimizable?
              util = Util
              if    util.constant?(left)  then left_invalid_constant?
              elsif util.constant?(right) then right_invalid_constant?
              else
                not_joinable?
              end
            end

          private

            def left_invalid_constant?
              !right.valid_value?(left)
            end

            def right_invalid_constant?
              !left.valid_value?(right)
            end

            def not_joinable?
              !left.joinable?(right)
            end

          end # module NeverEquivalent

          module NeverComparable
            def optimizable?
              util = Util
              if    util.constant?(left)  then left_invalid_constant?
              elsif util.constant?(right) then right_invalid_constant?
              else
                not_comparable?
              end
            end

          private

            def left_invalid_constant?
              !right.valid_primitive?(left)
            end

            def right_invalid_constant?
              !left.valid_primitive?(right)
            end

            def not_comparable?
              !left.comparable?(right)
            end

          end # module NeverComparable
        end # module Comparable
      end # class Predicate
    end # module Logic
  end # class Optimizer
end # module Veritas
