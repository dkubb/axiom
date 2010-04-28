module Veritas
  module Logic
    class Predicate
      class Match < Predicate
        def self.eval(left, right)
          right === left
        end

        def inspect
          "#{left.inspect} =~ #{right.inspect}"
        end

      end # class Match
    end # class Predicate
  end # module Logic
end # module Veritas
