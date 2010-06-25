module Veritas
  module Logic
    class Predicate
      class LessThan < Predicate
        include Comparable

        def self.operation
          :<
        end

        def self.complement
          GreaterThanOrEqualTo
        end

      private

        def swap
          GreaterThan.new(right, left)
        end

        def always_true?
          self.class.eval(left_max, right_min)
        end

        def always_false?
          never_comparable? || self.class.complement.eval(left_min, right_max)
        end

        def never_comparable?
          if    right_constant? then !right_valid_primitive?
          elsif left_constant?  then !left_valid_primitive?
          else
            same_attributes? || !comparable?
          end
        end

        memoize :optimize

        module Methods
          def lt(other)
            LessThan.new(self, other)
          end

        end # module Methods
      end # class LessThan
    end # class Predicate
  end # module Logic
end # module Veritas
