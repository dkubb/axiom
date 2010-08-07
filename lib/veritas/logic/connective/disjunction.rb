module Veritas
  module Logic
    class Connective
      class Disjunction < Connective
        include Binary

        def self.eval(left, right)
          left || right
        end

        def optimize
          left, right = optimize_left, optimize_right
          false_proposition = Proposition::False.instance

          if right.equal?(false_proposition)
            left
          elsif left.equal?(false_proposition)
            right
          elsif equality_with_same_attributes?
            new_inclusion
          else
            super
          end
        end

        def inspect
          "(#{left.inspect} OR #{right.inspect})"
        end

      private

        def always_true?
          true_proposition = Proposition::True.instance
          optimize_left.equal?(true_proposition)  ||
          optimize_right.equal?(true_proposition) ||
          inequality_with_same_attributes?        ||
          complementary_predicates?
        end

        def new_inclusion
          left = optimize_left
          Predicate::Inclusion.new(left.left, [ left.right, optimize_right.right ]).optimize
        end

        memoize :optimize

        module Methods
          extend Aliasable

          inheritable_alias(:| => :or)

          def or(other)
            Disjunction.new(self, other)
          end

        end # module Methods

        Connective::Methods.class_eval { include Methods }

      end # class Disjunction
    end # class Connective
  end # module Logic
end # module Veritas
