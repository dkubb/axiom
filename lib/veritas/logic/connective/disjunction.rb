module Veritas
  module Logic
    class Connective
      class Disjunction < Connective
        include BinaryConnective

        def self.eval(left, right)
          left || right
        end

        def optimize
          left, right = optimize_left, optimize_right

          if left.kind_of?(Proposition::True) || right.kind_of?(Proposition::True)
            Proposition::True.instance
          elsif right.kind_of?(Proposition::False)
            left
          elsif left.kind_of?(Proposition::False)
            right
          elsif collapse_to_inclusion?
            Predicate::Inclusion.new(left.left, [ left.right, right.right ])
          else
            super
          end
        end

        def inspect
          "(#{left.inspect} OR #{right.inspect})"
        end

      private

        def collapse_to_inclusion?
          left_and_right_equality?         &&
          left_and_right_same_attribute?   &&
          left_and_right_different_values?
        end

        def left_and_right_equality?
          optimize_left.kind_of?(Predicate::Equality) &&
          optimize_right.kind_of?(Predicate::Equality)
        end

        def left_and_right_same_attribute?
          optimize_left.left.eql?(optimize_right.left)
        end

        def left_and_right_different_values?
          left_value?       &&
          right_value?      &&
          different_values?
        end

        def left_value?
          !optimize_left.right.kind_of?(Attribute)
        end

        def right_value?
          !optimize_right.right.kind_of?(Attribute)
        end

        def different_values?
          !optimize_left.right.eql?(optimize_right.right)
        end

      end # class Disjunction
    end # class Connective
  end # module Logic
end # module Veritas
