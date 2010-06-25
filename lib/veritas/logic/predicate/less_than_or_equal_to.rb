module Veritas
  module Logic
    class Predicate
      class LessThanOrEqualTo < Predicate
        include Comparable

        def self.operation
          :<=
        end

        def self.complement
          GreaterThan
        end

      private

        def reverse
          GreaterThanOrEqualTo.new(right, left)
        end

        def always_true?
          always_equivalent? || self.class.complement.eval(right_min, left_max)
        end

        def always_false?
          never_comparable? || self.class.complement.eval(left_min, right_max)
        end

        def never_comparable?
          if    right_constant? then !right_valid_primitive?
          elsif left_constant?  then !left_valid_primitive?
          else
            !comparable?
          end
        end

        memoize :optimize

        module Methods
          def lte(other)
            LessThanOrEqualTo.new(self, other)
          end

        end # module Methods
      end # class LessThanOrEqualTo
    end # class Predicate
  end # module Logic
end # module Veritas
