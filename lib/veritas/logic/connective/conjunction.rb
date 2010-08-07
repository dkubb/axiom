module Veritas
  module Logic
    class Connective
      class Conjunction < Connective
        include Binary

        def self.eval(left, right)
          left && right
        end

        def optimize
          left, right = optimize_left, optimize_right
          true_proposition = Proposition::True.instance

          if right.equal?(true_proposition)
            left
          elsif left.equal?(true_proposition)
            right
          elsif inequality_with_same_attributes?
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
          false_proposition = Proposition::False.instance
          optimize_left.equal?(false_proposition)  ||
          optimize_right.equal?(false_proposition) ||
          equality_with_same_attributes?           ||
          complementary_predicates?
        end

        def new_exclusion
          left = optimize_left
          Predicate::Exclusion.new(left.left, [ left.right, optimize_right.right ]).optimize
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
