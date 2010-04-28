module Veritas
  module Logic
    class Connective
      class Conjunction < Connective
        include BinaryConnective

        def self.eval(left, right)
          left && right
        end

        def optimize
          left, right = optimize_left, optimize_right

          if left.kind_of?(Proposition::False) || right.kind_of?(Proposition::False)
            Proposition::False.instance
          elsif right.kind_of?(Proposition::True)
            left
          elsif left.kind_of?(Proposition::True)
            right
          else
            super
          end
        end

        def inspect
          "(#{left.inspect} AND #{right.inspect})"
        end

      end # class Conjunction
    end # class Connective
  end # module Logic
end # module Veritas
