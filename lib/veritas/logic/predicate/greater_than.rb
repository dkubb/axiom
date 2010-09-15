module Veritas
  module Logic
    class Predicate
      class GreaterThan < Predicate
        include Comparable

        def self.operation
          :>
        end

        def self.inverse
          LessThanOrEqualTo
        end

        def self.reverse
          LessThan
        end

        module Methods
          def gt(other)
            GreaterThan.new(self, other)
          end

        end # module Methods
      end # class GreaterThan
    end # class Predicate
  end # module Logic
end # module Veritas
