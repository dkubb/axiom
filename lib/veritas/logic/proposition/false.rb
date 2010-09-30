module Veritas
  module Logic
    class Proposition
      class False < Proposition

        # Return the inverse proposition class
        #
        # @example
        #   False.inverse  # => True
        #
        # @return [Class<True>]
        #
        # @api public
        def self.inverse
          True
        end

        # Evaluate the proposition
        #
        # @example
        #   False.call  # => false
        #
        # @return [false]
        #
        # @api public
        def self.call
          false
        end

        # Logically AND the proposition with another expression
        #
        # @example
        #   false_proposition.and(other)  # => false_proposition
        #
        # @param [Expression] other
        #
        # @return [self]
        #
        # @api public
        def and(other)
          self
        end

        # Logically OR the proposition with another expression
        #
        # @example
        #   false_proposition.or(other)  # => other
        #
        # @param [Expression] other
        #
        # @return [Expression]
        #
        # @api public
        def or(other)
          other
        end

      end # class False
    end # class Proposition
  end # module Algebra
end # module Veritas
