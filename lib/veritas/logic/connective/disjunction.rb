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

          if right.kind_of?(Proposition::False)
            left
          elsif left.kind_of?(Proposition::False)
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
          optimize_left.kind_of?(Proposition::True)  ||
          optimize_right.kind_of?(Proposition::True) ||
          inequality_with_same_attributes?
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
