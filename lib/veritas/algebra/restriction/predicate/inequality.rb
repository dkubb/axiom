module Veritas
  module Algebra
    class Restriction
      class Inequality < Predicate
        include ComparisonPredicate

        def self.eval(left, right)
          left != right
        end

        def invert
          Equality.new(left, right)
        end

        def inspect
          "#{left.inspect} != #{right.inspect}"
        end

      private

        def always_true?
          never_equivalent?
        end

        def always_false?
          always_equivalent?
        end

      end # class Inequality
    end # class Restriction
  end # module Algebra
end # module Veritas
