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

          if right.equal?(Proposition::False.instance)
            left
          elsif left.equal?(Proposition::False.instance)
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
          optimize_left.equal?(Proposition::True.instance)  ||
          optimize_right.equal?(Proposition::True.instance) ||
          inequality_with_same_attributes?                  ||
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
