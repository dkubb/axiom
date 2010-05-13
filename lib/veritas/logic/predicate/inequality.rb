module Veritas
  module Logic
    class Predicate
      class Inequality < Predicate
        include ComparisonPredicate

        def self.eval(left, right)
          left != right
        end

        def complement
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

        module Methods
          def ne(other)
            Inequality.new(self, other)
          end

        end # module Methods
      end # class Inequality
    end # class Predicate
  end # module Algebra
end # module Veritas
