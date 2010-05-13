module Veritas
  module Logic
    class Predicate
      class Equality < Predicate
        include ComparisonPredicate

        def self.eval(left, right)
          left == right
        end

        def complement
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

        module Methods
          def eq(other)
            Equality.new(self, other)
          end

        end # module Methods
      end # class Equality
    end # class Predicate
  end # module Logic
end # module Veritas
