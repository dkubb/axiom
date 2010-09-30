module Veritas
  module Logic
    class Connective
      class Disjunction < Connective
        include Binary

        def self.call(left, right)
          left || right
        end

        def inspect
          "(#{left.inspect} OR #{right.inspect})"
        end

        module Methods
          extend Aliasable

          inheritable_alias(:| => :or)

          def or(other)
            Disjunction.new(self, other)
          end

        end # module Methods

        Expression.class_eval { include Methods }

      end # class Disjunction
    end # class Connective
  end # module Logic
end # module Veritas
