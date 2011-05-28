# encoding: utf-8

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
          util = self.class
          util.call(util.extract_value(operand, tuple))
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
        # @todo handle case where operand is a literal
        #
        # @api public
        def rename(aliases)
          operand = self.operand
          util    = self.class

          renamed_operand = util.rename_attributes(operand, aliases)

          if operand.equal?(renamed_operand)
            self
          else
            util.new(renamed_operand)
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

        # Mixin for invertable unary functions
        module Invertible

          def self.included(descendant)
            descendant.memoize :inverse
          end

          # Return the inverse function
          #
          # @example
          #   inverse = function.inverse
          #
          # @return [Function]
          #
          # @todo move this to classes that use it
          #
          # @api public
          def inverse
            self.class.inverse.new(operand).
              memoize(:inverse, self)
          end

        end # module Invertible
      end # module Unary
  end # class Function
end # module Veritas
