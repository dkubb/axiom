module Veritas
  module Logic

    # Abstract base class for logical predicates
    class Predicate < Expression
      include AbstractClass, Operation::Binary

      # Evaluate the predicate using the provided Tuple
      #
      # @example
      #   value = predicate.call(tuple)
      #
      # @param [Tuple] tuple
      #
      # @return [Object]
      #
      # @api public
      def call(tuple)
        util = self.class
        util.call(
          util.extract_value(left,  tuple),
          util.extract_value(right, tuple)
        )
      end

      # Rename the contained attributes with the provided aliases
      #
      # @example
      #   renamed = predicate.rename(aliases)
      #
      # @param [Algebra::Rename::Aliases] aliases
      #   the old and new attributes
      #
      # @return [Predicate]
      #
      # @api public
      def rename(aliases)
        left  = self.left
        right = self.right
        util  = self.class

        renamed_left  = aliases[left]
        renamed_right = aliases[right]

        if left.equal?(renamed_left) && right.equal?(renamed_right)
          self
        else
          util.new(renamed_left, renamed_right)
        end
      end

      # Return the inverse predicate
      #
      # @example
      #   inverse = predicate.inverse
      #
      # @return [Predicate]
      #
      # @api public
      def inverse
        self.class.inverse.new(left, right).
          memoize(:inverse, self)
      end

      # Extract the value from the operand or tuple
      #
      # @param [Object, #call] operand
      #   the operand to extract the value from
      # @param [Tuple] tuple
      #   the tuple to pass in to the operand if it responds to #call
      #
      # @return [Object]
      #
      # @api private
      def self.extract_value(operand, tuple)
        operand.respond_to?(:call) ? operand.call(tuple) : operand
      end

      memoize :inverse

    end # class Predicate
  end # module Logic
end # module Veritas
