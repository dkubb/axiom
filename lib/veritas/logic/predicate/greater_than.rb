module Veritas
  module Logic
    class Predicate
      class GreaterThan < Predicate
        def self.eval(left, right)
          left > right
        end

        def invert
          LessThanOrEqualTo.new(left, right)
        end

        def inspect
          "#{left.inspect} > #{right.inspect}"
        end

      private

        def swap
          LessThan.new(right, left)
        end

        def always_true?
          left_min > right_max
        end

        def always_false?
          left  = self.left
          right = self.right

          left_attribute  = left_attribute?
          right_attribute = right_attribute?

          if left_attribute && right_attribute
            return true if     equivalent?
            return true unless comparable?

          elsif left_attribute
            return true unless left.valid_primitive?(right)

          elsif right_attribute
            return true unless right.valid_primitive?(left)

          end

          left_max <= right_min
        end

      end # class GreaterThan
    end # class Predicate
  end # module Logic
end # module Veritas
