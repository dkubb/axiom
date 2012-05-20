# encoding: utf-8

module Veritas
  class Function

      # Mixin for unary functions
      module Unary
        include Operation::Unary
        include Equalizer.new(self, :operand)

        # Mixin for adding #call to unary function classes
        module Callable

          # Hook called when module is included
          #
          # @param [Module] descendant
          #   the module or class including Callable
          #
          # @return [self]
          #
          # @api private
          def included(descendant)
            super
            descendant.extend(Callable)
            self
          end

          # Return the response from the unary operation called on the value
          #
          # @example
          #   callable.call(value)  # => any object
          #
          # @param [Object] value
          #
          # @return [Object]
          #
          # @api public
          def call(value)
            value.send(operation)
          end

        end # module Callable

        extend Callable

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

        # Mixin for invertable unary functions
        module Invertible

          # Hook called when module is included
          #
          # @param [Module] descendant
          #   the module or class including Invertible
          #
          # @return [self]
          #
          # @api private
          def self.included(descendant)
            super
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
            self.class.inverse.new(operand).memoize(:inverse, self)
          end

        end # module Invertible
      end # module Unary
  end # class Function
end # module Veritas
