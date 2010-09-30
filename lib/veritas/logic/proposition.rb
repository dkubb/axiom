module Veritas
  module Logic

    # Abstract base class for logical propositions
    class Proposition < Expression
      include Singleton

      # Instantiate a new Proposition
      #
      # @example using a true value
      #   true_proposition = Proposition.new(true)
      #
      # @example using a false value
      #   false_proposition = Proposition.new(false)
      #
      # @return [Proposition]
      #
      # @overload self.new(true)
      #   Return the True singleton instance
      #
      #   @param [Array(true)] *args
      #
      #   @return [True]
      #
      # @overload self.new(false)
      #   Return the False singleton instance
      #
      #   @param [Array(false)] *args
      #
      #   @return [False]
      #
      # @api public
      def self.new(*args)
        if args.empty?
          super
        else
          (args.first ? True : False).instance
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
      #   numeric_hash = proposition.hash
      #
      # @return [Integer]
      #
      # @api public
      def hash
        call.hash
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

require 'veritas/logic/proposition/false'
require 'veritas/logic/proposition/true'
