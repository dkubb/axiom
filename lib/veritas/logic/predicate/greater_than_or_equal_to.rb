module Veritas
  module Logic
    class Predicate
      class GreaterThanOrEqualTo < Predicate
        include Comparable

        def self.operation
          :>=
        end

        def self.complement
          LessThan
        end

      private

        def swap
          LessThanOrEqualTo.new(right, left)
        end

        def always_true?
          always_equivalent? || self.class.complement.eval(right_max, left_min)
        end

        def always_false?
          never_comparable? || self.class.complement.eval(left_max, right_min)
        end

        def never_comparable?
          if    right_constant? then !right_valid_primitive?
          elsif left_constant?  then !left_valid_primitive?
          else
            !comparable?
          end
        end

        module Methods
          def gte(other)
            GreaterThanOrEqualTo.new(self, other)
          end

        end # module Methods
      end # class GreaterThanOrEqualTo
    end # class Predicate
  end # module Logic
end # module Veritas
