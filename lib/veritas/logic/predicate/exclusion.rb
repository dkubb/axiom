# encoding: utf-8

module Veritas
  module Logic
    class Predicate
      class Exclusion < Predicate
        include Enumerable

        def self.eval(left, right)
          !right.include?(left)
        end

        def self.complement
          Inclusion
        end

        def inspect
          "#{left.inspect} ∉ #{right.inspect}"
        end

      private

        def new_optimized_one
          Inequality.new(left, optimize_right.first)
        end

        def new_optimized_none
          Proposition::True.instance
        end

        memoize :optimize

        module Methods
          def exclude(other)
            Exclusion.new(self, other)
          end

        end # module Methods
      end # class Exclusion
    end # class Predicate
  end # module Logic
end # module Veritas
