module Veritas
  module Logic
    class Connective
      class Negation < Unary

        def self.call(operand)
          !operand
        end

        def inverse
          operand
        end

        def inspect
          "not(#{operand.inspect})"
        end

        module Methods
          extend Aliasable

          inheritable_alias(:- => :not)

          def not(other)
            self.and(Negation.new(other))
          end

        end # module Methods

        Expression.class_eval { include Methods }

      end # class Negation
    end # class Connective
  end # module Logic
end # module Veritas
