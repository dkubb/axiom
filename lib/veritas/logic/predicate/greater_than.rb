module Veritas
  module Logic
    class Predicate
      class GreaterThan < Predicate
        include Comparable

        def self.operation
          :>
        end

        def self.complement
          LessThanOrEqualTo
        end

        def self.reverse
          LessThan
        end

      private

        def always_true?
          self.class.eval(left_min, right_max)
        end

        def always_false?
          never_comparable? || self.class.complement.eval(left_max, right_min)
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
          def gt(other)
            GreaterThan.new(self, other)
          end

        end # module Methods
      end # class GreaterThan
    end # class Predicate
  end # module Logic
end # module Veritas
