module Veritas
  module Function
    class Proposition

      # A class representing a contradiction
      class Contradiction < Proposition

        # Return the inverse proposition class
        #
        # @example
        #   Contradiction.inverse  # => Tautology
        #
        # @return [Class<Tautology>]
        #
        # @api public
        def self.inverse
          Tautology
        end

        # Evaluate the proposition
        #
        # @example
        #   Contradiction.call  # => false
        #
        # @return [false]
        #
        # @api public
        def self.call
          false
        end

        # Functionally AND the proposition with another expression
        #
        # @example
        #   contradiction.and(other)  # => contradiction
        #
        # @param [Expression] other
        #
        # @return [self]
        #
        # @api public
        def and(other)
          self
        end

        # Functionally OR the proposition with another expression
        #
        # @example
        #   contradiction.or(other)  # => other
        #
        # @param [Expression] other
        #
        # @return [Expression]
        #
        # @api public
        def or(other)
          other
        end

      end # class Contradiction
    end # class Proposition
  end # module Algebra
end # module Veritas
