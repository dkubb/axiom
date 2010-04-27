module Veritas
  module Algebra
    class Restriction
      class Equality < Predicate
        include ComparisonPredicate

        def self.eval(left, right)
          left == right
        end

        def invert
          Inequality.new(left, right)
        end

        def inspect
          "#{left.inspect} == #{right.inspect}"
        end

      private

        def always_true?
          always_equivalent?
        end

        def always_false?
          never_equivalent?
        end

      end # class Equality
    end # class Restriction
  end # module Algebra
end # module Veritas
