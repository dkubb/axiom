module Veritas
  class Function

    # Mixin for binary functions
    module Binary
      include Operation::Binary

      # Evaluate the binary connective using the tuple
      #
      # @example
      #   binary.call(tuple)  # => true or false
      #
      # @param [Tuple] tuple
      #   the tuple to pass to #call in the left and right operands
      #
      # @return [Boolean]
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
      #   renamed = binary.rename(aliases)
      #
      # @param [Algebra::Rename::Aliases] aliases
      #   the old and new attributes
      #
      # @return [self]
      #   if the left and right operands are not renamed
      # @return [Binary]
      #   if the left or right operand is renamed
      #
      # @todo handle case where left/right are literals
      #
      # @api public
      def rename(aliases)
        left          = self.left
        right         = self.right
        renamed_left  = left.rename(aliases)
        renamed_right = right.rename(aliases)

        if left.equal?(renamed_left) && right.equal?(renamed_right)
          self
        else
          self.class.new(renamed_left, renamed_right)
        end
      end

      # Compare the operation with the other operation for equivalency
      #
      # @example
      #   binary == other  # => true or false
      #
      # @param [Object] other
      #
      # @return [Boolean]
      #
      # @api public
      def ==(other)
        (kind_of?(other.class) || other.kind_of?(self.class)) &&
        left  == other.left                                   &&
        right == other.right
      end

    end # module Binary
  end # class Function
end # module Veritas
