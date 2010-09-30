module Veritas
  module Logic
    class Connective

      # Abstract base class for binary connectives
      class Binary < Connective
        include AbstractClass, Operation::Binary

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
          self.class.call(left.call(tuple), right.call(tuple))
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

        # Return the inverse connective
        #
        # @example
        #   negation = binary.inverse
        #
        # @return [Negation]
        #
        # @api public
        def inverse
          Negation.new(self)
        end

        memoize :inverse

      end # class Binary
    end # class Connective
  end # module Logic
end # module Veritas
