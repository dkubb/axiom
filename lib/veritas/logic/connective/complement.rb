module Veritas
  module Logic
    class Connective
      class Complement < Connective
        include Operation::Unary

        def self.eval(value)
          !value
        end

        def call(tuple)
          self.class.eval(operand.call(tuple))
        end

        def complement
          operand
        end

        def project(attributes)
          return nil if operand.project(attributes).nil?
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

        def optimize
          operand.optimize.complement
        end

        def inspect
          "NOT(#{operand.inspect})"
        end

        module Methods
          extend Aliasable

          inheritable_alias(:- => :not)

          def not(other)
            self.and(Complement.new(other))
          end

        end # module Methods

        Connective::Methods.class_eval { include Methods }

      end # class Complement
    end # class Connective
  end # module Logic
end # module Veritas
