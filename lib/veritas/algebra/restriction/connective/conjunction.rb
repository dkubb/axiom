module Veritas
  module Algebra
    class Restriction
      class Conjunction < Connective
        include BinaryConnective

        def self.eval(left, right)
          left && right
        end

        def optimize
          left, right = optimize_left, optimize_right

          if left.kind_of?(False) || right.kind_of?(False)
            False.instance
          elsif right.kind_of?(True)
            left
          elsif left.kind_of?(True)
            right
          else
            super
          end
        end

        def inspect
          "(#{left.inspect} AND #{right.inspect})"
        end

      end # class Conjunction
    end # class Restriction
  end # module Algebra
end # module Veritas
