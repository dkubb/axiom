module Veritas
  module Logic
    class Connective
      class Negation < Connective
        extend Aliasable
        include Operation::Unary

        inheritable_alias(:inverse => :operand)

        def self.call(operand)
          !operand
        end

        def call(tuple)
          self.class.call(operand.call(tuple))
        end

        def project(attributes)
          return if operand.project(attributes).nil?
          super
        end

        def rename(aliases)
          operand         = self.operand
          renamed_operand = operand.rename(aliases)

          if operand.equal?(renamed_operand)
            self
          else
            self.class.new(renamed_operand)
          end
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
