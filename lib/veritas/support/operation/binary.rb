module Veritas
  module Operation
    module Binary
      include Immutable

      # The left operand for the operation
      #
      # @example
      #   left = binary.left
      #
      # @return [Object]
      #
      # @api public
      attr_reader :left

      # The right operand for the operation
      #
      # @example
      #   right = binary.right
      #
      # @return [Object]
      #
      # @api public
      attr_reader :right

      # Initialize Binary Operation
      #
      # @param [Object] left
      #   the left operand for the operation
      # @param [Object] right
      #   the right operand for the operation
      #
      # @return [undefined]
      #
      # @api private
      def initialize(left, right)
        @left  = Immutable.freeze_object(left)
        @right = Immutable.freeze_object(right)
      end

      # Compare the operation with the other operation for equality
      #
      # @example
      #   binary.eql?(other)  # => true or false
      #
      # @param [Object] other
      #
      # @return [Boolean]
      #
      # @api public
      def eql?(other)
        instance_of?(other.class) &&
        left.eql?(other.left)     &&
        right.eql?(other.right)
      end

      # Return the hash of the left and right operands
      #
      # @example
      #   hash = binary.hash
      #
      # @return [Fixnum]
      #
      # @api public
      def hash
        self.class.hash ^ left.hash ^ right.hash
      end

      memoize :hash

    end # module Binary
  end # module Operation
end # module Veritas
