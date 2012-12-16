# encoding: utf-8

module Veritas
  class Function
    class Proposition

      # A class representing a contradiction
      class Contradiction < Proposition
        include Connective::Negation::Methods

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

        # Logically AND the proposition with another expression
        #
        # @example
        #   contradiction.and(other)  # => contradiction
        #
        # @param [Function]
        #
        # @return [self]
        #
        # @api public
        def and(*)
          self
        end

        # Logically OR the proposition with another expression
        #
        # @example
        #   contradiction.or(other)  # => other
        #
        # @param [Function] other
        #
        # @return [Function]
        #
        # @api public
        def or(other)
          other
        end

      end # class Contradiction
    end # class Proposition
  end # module Algebra
end # module Veritas
