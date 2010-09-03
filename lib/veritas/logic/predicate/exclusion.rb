# encoding: utf-8

module Veritas
  module Logic
    class Predicate
      class Exclusion < Predicate
        include Enumerable

        def self.call(left, right)
          !right.include?(left)
        end

        def self.complement
          Inclusion
        end

        def inspect
          "#{left.inspect} ∉ #{right.inspect}"
        end

        module Methods
          def exclude(other)
            Exclusion.new(self, other)
          end

        end # module Methods
      end # class Exclusion
    end # class Predicate
  end # module Logic
end # module Veritas
