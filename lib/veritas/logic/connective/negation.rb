module Veritas
  module Logic
    class Connective
      class Negation < Connective
        attr_reader :operand

        def initialize(operand)
          @operand = operand
        end

        def call(tuple)
          self.class.eval(operand.call(tuple))
        end

        def invert
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
          operand.optimize.invert
        end

        def eql?(other)
          instance_of?(other.class) &&
          operand.eql?(other.operand)
        end

        def hash
          @hash ||= operand.hash
        end

        def inspect
          "NOT(#{operand.inspect})"
        end

        def self.eval(value)
          !value
        end

      end # class Negation
    end # class Connective
  end # module Logic
end # module Veritas
