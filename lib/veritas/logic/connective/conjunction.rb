module Veritas
  module Logic
    class Connective
      class Conjunction < Binary
        def self.call(left, right)
          left && right
        end

        def inspect
          "(#{left.inspect} AND #{right.inspect})"
        end

        module Methods
          extend Aliasable

          inheritable_alias(:& => :and)

          def and(other)
            Conjunction.new(self, other)
          end

        end # module Methods

        Expression.class_eval { include Methods }

      end # class Conjunction
    end # class Connective
  end # module Logic
end # module Veritas
