# encoding: utf-8

module Axiom
  class Function
    class Connective

      # A logical OR between expressions
      class Disjunction < Connective
        include Binary, Binary::Invertible

        undef_method :inverse

        # Evaluate the operands using a logical OR
        #
        # @example with true operands
        #   Disjunction.call(true, true)  # => true
        #
        # @example with true and false
        #   Disjunction.call(true, false)  # => true
        #
        # @example with false and true
        #   Disjunction.call(false, true)  # => true
        #
        # @example with false and false
        #   Disjunction.call(false, false)  # => false
        #
        # @param [Boolean] left
        # @param [Boolean] right
        #
        # @return [Boolean]
        #
        # @api public
        def self.call(left, right)
          left || right
        end

        # Return the inverse connective
        #
        # @example
        #   conjunction = disjunction.inverse
        #
        # @return [Conjunction]
        #
        # @api public
        def inverse
          Conjunction.new(Negation.new(left), Negation.new(right))
            .memoize(:inverse, self)
        end

        module Methods
          extend Aliasable

          inheritable_alias(:| => :or)

          # Logically OR the expression with another expression
          #
          # @example
          #   disjunction = expression.or(other)
          #
          # @param [Function] other
          #
          # @return [Disjunction]
          #
          # @api public
          def or(other)
            Disjunction.new(self, other)
          end

        end # module Methods

        Connective.class_eval { include Methods }

        memoize :inverse

      end # class Disjunction
    end # class Connective
  end # class Function
end # module Axiom
