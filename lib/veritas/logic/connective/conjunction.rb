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

          if always_false?
            Proposition::False.instance
          elsif right.kind_of?(Proposition::True)
            left
          elsif left.kind_of?(Proposition::True)
            right
          elsif collapse_to_exclusion?
            new_exclusion
          else
            super
          end
        end

        def inspect
          "(#{left.inspect} AND #{right.inspect})"
        end

      private

        def always_false?
          optimize_left.kind_of?(Proposition::False) || optimize_right.kind_of?(Proposition::False)
        end

        def new_exclusion
          left = optimize_left
          Predicate::Exclusion.new(left.left, [ left.right, optimize_right.right ]).optimize
        end

        def collapse_to_exclusion?
          left_and_right_inequality?     &&
          left_and_right_same_attribute? &&
          left_and_right_constants?
        end

        def left_and_right_inequality?
          optimize_left.kind_of?(Predicate::Inequality) &&
          optimize_right.kind_of?(Predicate::Inequality)
        end

        memoize :optimize

        module Methods
          extend Aliasable

          inheritable_alias(:& => :and)

          def and(other)
            Conjunction.new(self, other)
          end

        end # module Methods

        Connective::Methods.class_eval { include Methods }

      end # class Conjunction
    end # class Connective
  end # module Logic
end # module Veritas
