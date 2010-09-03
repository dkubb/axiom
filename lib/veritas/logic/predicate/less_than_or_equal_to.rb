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

        def self.reverse
          GreaterThanOrEqualTo
        end

        module Methods
          def lte(other)
            LessThanOrEqualTo.new(self, other)
          end

        end # module Methods
      end # class LessThanOrEqualTo
    end # class Predicate
  end # module Logic
end # module Veritas
