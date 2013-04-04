# encoding: utf-8

module Axiom
  class Function

    # Mixin for binary functions
    module Binary
      include Operation::Binary

      # Evaluate the binary function using the tuple
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
        util          = self.class
        renamed_left  = util.rename_attributes(left,  aliases)
        renamed_right = util.rename_attributes(right, aliases)

        if left.equal?(renamed_left) && right.equal?(renamed_right)
          self
        else
          util.new(renamed_left, renamed_right)
        end
      end

      # Mixin for invertable binary functions
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
        # @api public
        def inverse
          self.class.inverse.new(left, right).memoize(:inverse, self)
        end

      end # module Invertible
    end # module Binary
  end # class Function
end # module Axiom
