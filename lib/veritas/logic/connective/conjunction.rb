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
