# encoding: utf-8

module Veritas
  module Logic
    class Predicate
      class Inclusion < Predicate
        include Enumerable

        def self.call(left, right)
          right.include?(left)
        end

        def self.inverse
          Exclusion
        end

        def inspect
          "#{left.inspect} ∈ #{right.inspect}"
        end

        module Methods
          def include(other)
            Inclusion.new(self, other)
          end

        end # module Methods
      end # class Inclusion
    end # class Predicate
  end # module Logic
end # module Veritas
