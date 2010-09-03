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

        def self.reverse
          GreaterThan
        end

        module Methods
          def lt(other)
            LessThan.new(self, other)
          end

        end # module Methods
      end # class LessThan
    end # class Predicate
  end # module Logic
end # module Veritas
