module Veritas
  class Function
    class Connective

      # A logical AND between expressions
      class Conjunction < Binary

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

        # Return a string representing the conjunction
        #
        # @example
        #   conjunction.inspect  # "<Function1> AND <Function2>"
        #
        # @return [String]
        #
        # @api public
        def inspect
          "(#{left.inspect} AND #{right.inspect})"
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

        Function.class_eval { include Methods }

      end # class Conjunction
    end # class Connective
  end # class Function
end # module Veritas
