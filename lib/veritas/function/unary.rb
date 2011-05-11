module Veritas
  class Function

      # Mixin for unary functions
      module Unary
        include Operation::Unary

        # Evaluate the unary connective using the tuple
        #
        # @example
        #   unary.call(tuple)  # => true or false
        #
        # @param [Tuple] tuple
        #   the tuple to pass to operand#call
        #
        # @return [Boolean]
        #
        # @api public
        def call(tuple)
          self.class.call(operand.call(tuple))
        end

        # Rename the contained attributes with the provided aliases
        #
        # @example
        #   renamed = unary.rename(aliases)
        #
        # @param [Algebra::Rename::Aliases] aliases
        #   the old and new attributes
        #
        # @return [self]
        #   if the operand is not renamed
        # @return [Unary]
        #   if the operand is renamed
        #
        # @api public
        def rename(aliases)
          operand         = self.operand
          renamed_operand = operand.rename(aliases)

          if operand.equal?(renamed_operand)
            self
          else
            self.class.new(renamed_operand)
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
          operand == other.operand
        end

      end # module Unary
  end # class Function
end # module Veritas
