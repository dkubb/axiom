module Veritas
  module Logic
    class Connective

      # Abstract base class for unary connectives
      class Unary < Connective
        include AbstractClass, Operation::Unary

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

      end # class Unary
    end # class Connective
  end # module Logic
end # module Veritas
