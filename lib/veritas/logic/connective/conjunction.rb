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

          if right.equal?(Proposition::True.instance)
            left
          elsif left.equal?(Proposition::True.instance)
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
          optimize_left.equal?(Proposition::False.instance)  ||
          optimize_right.equal?(Proposition::False.instance) ||
          equality_with_same_attributes?                     ||
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
