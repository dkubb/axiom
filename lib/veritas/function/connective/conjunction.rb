# encoding: utf-8

module Veritas
  class Function
    class Connective

      # A logical AND between expressions
      class Conjunction < Connective
        include Binary, Binary::Invertible

        # Evaluate the operands using a logical AND
        #
        # @example with true operands
        #   Conjunction.call(true, true)  # => true
        #
        # @example with true and false
        #   Conjunction.call(true, false)  # => false
        #
        # @example with false and true
        #   Conjunction.call(false, true)  # => false
        #
        # @example with false and false
        #   Conjunction.call(false, false)  # => false
        #
        # @param [Boolean] left
        # @param [Boolean] right
        #
        # @return [Boolean]
        #
        # @api public
        def self.call(left, right)
          left && right
        end

        # Return the inverse connective
        #
        # @example
        #   disjunction = conjunction.inverse
        #
        # @return [Disjunction]
        #
        # @api public
        def inverse
          Disjunction.new(Negation.new(left), Negation.new(right)).
            memoize(:inverse, self)
        end

        module Methods
          extend Aliasable

          inheritable_alias(:& => :and)

          # Logically AND the expression with another expression
          #
          # @example
          #   conjunction = expression.and(other)
          #
          # @param [Function] other
          #
          # @return [Conjunction]
          #
          # @api public
          def and(other)
            Conjunction.new(self, other)
          end

        end # module Methods

        Connective.class_eval { include Methods }

        memoize :inverse

      end # class Conjunction
    end # class Connective
  end # class Function
end # module Veritas
