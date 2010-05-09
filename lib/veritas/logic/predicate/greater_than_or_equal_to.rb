module Veritas
  module Logic
    class Predicate
      class GreaterThanOrEqualTo < Predicate
        include ComparisonPredicate

        def self.eval(left, right)
          left >= right
        end

        def complement
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
          always_equivalent? || left_min > right_max
        end

        def always_false?
          never_comparable? || left_max < right_min
        end

        def never_comparable?
          if    right_constant? then !right_valid_primitive?
          elsif left_constant?  then !left_valid_primitive?
          else
            !comparable?
          end
        end

      end # class GreaterThanOrEqualTo
    end # class Predicate
  end # module Logic
end # module Veritas
