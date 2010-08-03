module Veritas
  module Logic
    class Predicate
      class Inequality < Predicate
        include Comparable

        def self.operation
          :'!='
        end

        def self.complement
          Equality
        end

        def self.reverse
          self
        end

        def self.eval(left, right)
          left != right
        end unless Object.method_defined?(operation)

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
