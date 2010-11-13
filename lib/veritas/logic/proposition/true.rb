module Veritas
  module Logic
    class Proposition

      # A class representing a tautology
      class True < Proposition

        # Return the inverse proposition class
        #
        # @example
        #   True.inverse  # => False
        #
        # @return [Class<False>]
        #
        # @api public
        def self.inverse
          False
        end

        # Evaluate the proposition
        #
        # @example
        #   True.call  # => true
        #
        # @return [true]
        #
        # @api public
        def self.call
          true
        end

        # Logically AND the proposition with another expression
        #
        # @example
        #   true_proposition.and(other)  # => other
        #
        # @param [Expression] other
        #
        # @return [Expression]
        #
        # @api public
        def and(other)
          other
        end

        # Logically OR the proposition with another expression
        #
        # @example
        #   true_proposition.or(other)  # => true_proposition
        #
        # @param [Expression] other
        #
        # @return [self]
        #
        # @api public
        def or(other)
          self
        end

      end # class True
    end # class Proposition
  end # module Algebra
end # module Veritas
