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

        def self.reverse
          LessThanOrEqualTo
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
