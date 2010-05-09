module Veritas
  module Logic
    class Predicate
      class LessThan < Predicate
        def self.eval(left, right)
          left < right
        end

        def complement
          GreaterThanOrEqualTo.new(left, right)
        end

        def inspect
          "#{left.inspect} < #{right.inspect}"
        end

      private

        def swap
          GreaterThan.new(right, left)
        end

        def always_true?
          left_max < right_min
        end

        def always_false?
          never_comparable? || left_min >= right_max
        end

        def never_comparable?
          if    right_constant? then !right_valid_primitive?
          elsif left_constant?  then !left_valid_primitive?
          else
            same_attributes? || !comparable?
          end
        end

      end # class LessThan
    end # class Predicate
  end # module Logic
end # module Veritas
