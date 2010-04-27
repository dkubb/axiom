module Veritas
  module Algebra
    class Restriction
      class GreaterThanOrEqualTo < Predicate
        def self.eval(left, right)
          left >= right
        end

        def invert
          LessThan.new(left, right)
        end

        def inspect
          "#{left.inspect} >= #{right.inspect}"
        end

      private

        def swap
          LessThanOrEqualTo.new(right, left)
        end

        def always_true?
          if left_attribute? && right_attribute? && equivalent?
            true
          else
            left_min > right_max
          end
        end

        def always_false?
          left  = self.left
          right = self.right

          left_attribute  = left_attribute?
          right_attribute = right_attribute?

          if left_attribute && right_attribute
            return true unless comparable?

          elsif left_attribute
            return true unless left.valid_primitive?(right)

          elsif right_attribute
            return true unless right.valid_primitive?(left)

          end

          left_max < right_min
        end

      end # class GreaterThanOrEqualTo
    end # class Restriction
  end # module Algebra
end # module Veritas
