module Veritas
  module Logic

    # Abstract base class for logical expressions
    class Expression
      extend Aliasable
      include AbstractClass, Optimizable, Immutable

      # Evaluate the expression using the operands
      #
      # @return [undefined]
      #
      # @api public
      def self.call(*)
        raise NotImplementedError, "#{name}.call must be implemented"
      end

      # Rename the contained attributes with the provided aliases
      #
      # @example
      #   renamed = expression.rename(aliases)
      #
      # @param [Algebra::Rename::Aliases] aliases
      #   the old and new attributes
      #
      # @return [self]
      #
      # @api public
      def rename(aliases)
        self
      end

      # Return the inverse expression
      #
      # @example
      #   inverse = expression.inverse
      #
      # @return [Expression]
      #
      # @api public
      def inverse
        raise NotImplementedError, "#{self.class}#inverse must be implemented"
      end

      # Compare the expression with other expression for equivalency
      #
      # @example
      #   expression == other  # => true or false
      #
      # @param [Expression] other
      #
      # @return [Boolean]
      #
      # @api public
      def ==(other)
        optimize.eql?(other.optimize)
      end

      # Compare the expression with other expression for equality
      #
      # @example
      #   expression.eql?(other)  # => true or false
      #
      # @param [Expression] other
      #
      # @return [Boolean]
      #
      # @api public
      def eql?(other)
        raise NotImplementedError, "#{self.class}#eql? must be implemented"
      end

      # Return the hash of the expression
      #
      # @example
      #   hash = expression.hash
      #
      # @return [Fixnum]
      #
      # @api public
      def hash
        raise NotImplementedError, "#{self.class}#hash must be implemented"
      end

      # Return a string representing the expression
      #
      # @example
      #   expression.inspect  # (String representation of Expression)
      #
      # @return [String]
      #
      # @api public
      def inspect
        raise NotImplementedError, "#{self.class}#inspect must be implemented"
      end

    end # class Expression
  end # module Logic
end # module Veritas
