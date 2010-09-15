module Veritas
  module Logic
    class Predicate
      class Inequality < Predicate
        include Comparable

        def self.operation
          :'!='
        end

        def self.inverse
          Equality
        end

        def self.reverse
          self
        end

        def self.call(left, right)
          left != right
        end unless Object.method_defined?(operation)

        module Methods
          def ne(other)
            Inequality.new(self, other)
          end

        end # module Methods
      end # class Inequality
    end # class Predicate
  end # module Algebra
end # module Veritas
