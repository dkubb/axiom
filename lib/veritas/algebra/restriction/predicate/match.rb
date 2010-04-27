module Veritas
  module Algebra
    class Restriction
      class Match < Predicate
        def self.eval(left, right)
          right === left
        end

        def inspect
          "#{left.inspect} =~ #{right.inspect}"
        end

      end # class Match
    end # class Restriction
  end # module Algebra
end # module Veritas
