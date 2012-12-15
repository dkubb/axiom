# encoding: utf-8

module Veritas
  class Function

    # Abstract base class for logical propositions
    class Proposition < Function
      include AbstractType,
              Singleton,
              Function::Connective::Conjunction::Methods,
              Function::Connective::Disjunction::Methods,
              Function::Connective::Negation::Methods
      include Equalizer.new

      # Instantiate a new Proposition
      #
      # @example using a true value
      #   tautology = Proposition.new(true)
      #
      # @example using a false value
      #   contradiction = Proposition.new(false)
      #
      # @return [Proposition]
      #
      # @overload self.new(true)
      #   Return the Tautology singleton instance
      #
      #   @param [Array(true)] args
      #
      #   @return [Tautology]
      #
      # @overload self.new(false)
      #   Return the Contradiction singleton instance
      #
      #   @param [Array(false)] args
      #
      #   @return [Contradiction]
      #
      # @api public
      def self.new(*args)
        if args.empty?
          super
        else
          (args.first.equal?(true) ? Tautology : Contradiction).instance
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
      # @param [Algebra::Rename::Aliases] aliases
      #
      # @return [self]
      #
      # @api public
      def rename(aliases)
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

      # Return the type returned from #call
      #
      # @return [Class<Attribute::Boolean>]
      #
      # @api public
      def type
        Attribute::Boolean
      end

    end # class Proposition
  end # module Algebra
end # module Veritas
