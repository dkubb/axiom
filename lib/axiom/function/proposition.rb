# encoding: utf-8

module Axiom
  class Function

    # Abstract base class for logical propositions
    class Proposition < Function
      include Singleton,
              Function::Connective::Conjunction::Methods,
              Function::Connective::Disjunction::Methods,
              Function::Connective::Negation::Methods
      include Equalizer.new

      # Return the type returned from #call
      #
      # @example
      #   type = Axiom::Function::Proposition.type  # => Axiom::Types::Boolean
      #
      # @return [Class<Types::Boolean>]
      #
      # @api public
      def self.type
        Types::Boolean
      end

      # Coerce a boolean into a proposition
      #
      # @param [Object] object
      #
      # @return [Proposition]
      #   returned twhen the object can be coerced into a proposition
      #
      # @raise [ArgumentError]
      #   raised when the object cannot be coerced into a proposition
      #
      # @api public
      def self.coerce(object)
        case object
        when Proposition then object
        when true        then Tautology.instance
        when false       then Contradiction.instance
        else
          fail ArgumentError, "Invalid object #{object.inspect}"
        end
      end

      # Evaluate the proposition
      #
      # @example
      #   proposition.call  # => true or false
      #
      # @return [Boolean]
      #
      # @api public
      def call(*)
        self.class.call
      end

      # A no-op when receiving #rename message
      #
      # @example
      #   proposition = proposition.rename(aliases)
      #
      # @param [Algebra::Rename::Aliases] _aliases
      #
      # @return [self]
      #
      # @api public
      def rename(_aliases)
        self
      end

      # Return the inverse proposition
      #
      # @example
      #   inverse = proposition.inverse
      #
      # @return [Proposition]
      #
      # @api public
      def inverse
        self.class.inverse.instance
      end

    end # class Proposition
  end # module Algebra
end # module Axiom
