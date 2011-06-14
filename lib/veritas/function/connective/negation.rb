# encoding: utf-8

module Veritas
  class Function
    class Connective

      # A logical negation of an expression
      class Negation < Connective
        include Unary, Unary::Invertible

        # Evaluate the operands using a logical NOT
        #
        # @example with true operand
        #   Negation.call(true)  # => false
        #
        # @example with false operand
        #   Negation.call(false)  # => true
        #
        # @param [Boolean] operand
        #
        # @return [Boolean]
        #
        # @api public
        def self.call(operand)
          !operand
        end

        # Return the operand
        #
        # @example
        #   operand = negation.inverse
        #
        # @return [Function]
        #
        # @api public
        def inverse
          operand
        end

        # Return a string representing the negation
        #
        # @example
        #   negation.inspect  # not(<Function>)
        #
        # @return [String]
        #
        # @api public
        def inspect
          "NOT(#{operand.inspect})"
        end

        module Methods
          extend Aliasable

          # alias #! to #inverse when available
          inheritable_alias('!' => :inverse) if Object.method_defined?('!')

          inheritable_alias(:- => :not)

          # Negate the expression or logically AND and negate another expression
          #
          # @example with no argument
          #   negation = expression.not
          #
          # @example with other argument
          #   conjunction = expression.not(other)
          #
          # @return [Connective]
          #
          # @overload not
          #   Negates the expression
          #
          #   @return [Negation]
          #
          # @overload not(other)
          #   Logically AND the other negated expression
          #
          #   @param [Function] other
          #     optional other function to and
          #
          #   @return [Conjunction]
          #
          # @api public
          def not(other = Undefined)
            if other.equal?(Undefined)
              Negation.new(self)
            else
              self.and(Negation.new(other))
            end
          end

        end # module Methods

        Connective.class_eval { include Methods }

        memoize :inverse

      end # class Negation
    end # class Connective
  end # class Function
end # module Veritas
