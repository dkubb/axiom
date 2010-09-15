module Veritas
  module Logic
    class Predicate
      class Equality < Predicate
        include Comparable

        def self.operation
          :==
        end

        def self.inverse
          Inequality
        end

        def self.reverse
          self
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
