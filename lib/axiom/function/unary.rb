# encoding: utf-8

module Axiom
  class Function

    # Mixin for unary functions
    module Unary
      include Operation::Unary
      include Equalizer.new(:operand)

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
          value.public_send(operation)
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
        util            = self.class
        renamed_operand = util.rename_attributes(operand, aliases)

        if operand.equal?(renamed_operand)
          self
        else
          util.new(renamed_operand)
        end
      end

      # Return the type returned from #call
      #
      # @example
      #   type = unary.type  # => Axiom::Types::Numeric
      #
      # @return [Class<Types::Numeric>]
      #
      # @api public
      def type
        Attribute.infer_type(operand)
      end

      # Mixin for invertable unary functions
      module Invertible

        # Hook called when module is included
        #
        # @param [Module] descendant
        #   the module or class including Invertible
        #
        # @return [undefined]
        #
        # @api private
        def self.included(descendant)
          super
          descendant.memoize :inverse
        end

        private_class_method :included

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
end # module Axiom
