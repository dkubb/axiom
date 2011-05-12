module Veritas
  class Function

    # Abstract base class for logical propositions
    class Proposition < Function
      include AbstractClass, Singleton

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
      #   @param [Array(true)] *args
      #
      #   @return [Tautology]
      #
      # @overload self.new(false)
      #   Return the Contradiction singleton instance
      #
      #   @param [Array(false)] *args
      #
      #   @return [Contradiction]
      #
      # @api public
      def self.new(*args)
        if args.empty?
          super
        else
          (args.first ? Tautology : Contradiction).instance
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

      # Compare the proposition with other proposition for equivalency
      #
      # @example
      #   proposition == other  # => true or false
      #
      # @param [Proposition] other
      #
      # @return [Boolean]
      #
      # @api public
      def ==(other)
        kind_of?(other.class) || other.kind_of?(self.class)
      end

      # Compare the proposition with other proposition for equality
      #
      # @example
      #   proposition.eql?(other)  # => true or false
      #
      # @param [Proposition] other
      #
      # @return [Boolean]
      #
      # @api public
      def eql?(other)
        instance_of?(other.class)
      end

      # Return the hash of the proposition
      #
      # @example
      #   hash = proposition.hash
      #
      # @return [Fixnum]
      #
      # @api public
      def hash
        self.class.hash
      end

      # Return a string representing the proposition
      #
      # @example
      #   proposition.inspect  # (String representation of Proposition)
      #
      # @return [String]
      #
      # @api public
      def inspect
        call.inspect
      end

      memoize :hash

    end # class Proposition
  end # module Algebra
end # module Veritas
