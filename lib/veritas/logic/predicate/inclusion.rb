# encoding: utf-8

module Veritas
  module Logic
    class Predicate
      class Inclusion < Predicate
        include Enumerable

        def self.eval(left, right)
          right.include?(left)
        end

        def self.complement
          Exclusion
        end

        def inspect
          "#{left.inspect} ∈ #{right.inspect}"
        end

      private

        def new_optimized_one
          Equality.new(left, optimize_right.first)
        end

        def new_optimized_none
          Proposition::False.instance
        end

        memoize :optimize

        module Methods
          def include(other)
            Inclusion.new(self, other)
          end

        end # module Methods
      end # class Inclusion
    end # class Predicate
  end # module Logic
end # module Veritas
