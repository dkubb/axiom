module Veritas
  module Operation
    module Unary
      include Immutable

      # The operand to the operation
      #
      # @example
      #   operand = unary.operand
      #
      # @return [Object]
      #
      # @api public
      attr_reader :operand

      # Initialize Unary Operation
      #
      # @param [Object] operand
      #   the operand for the operation
      #
      # @return [undefined]
      #
      # @api private
      def initialize(operand)
        @operand = Immutable.freeze_object(operand)
      end

      # Compare the operation with the other operation for equality
      #
      # @example
      #   unary.eql?(other)  # => true or false
      #
      # @param [Object] other
      #
      # @return [Boolean]
      #
      # @api public
      def eql?(other)
        instance_of?(other.class) &&
        operand.eql?(other.operand)
      end

      # Return the hash of the operand
      #
      # @example
      #   hash = unary.hash
      #
      # @return [Fixnum]
      #
      # @api public
      def hash
        self.class.hash ^ operand.hash
      end

      memoize :hash

    end # module Unary
  end # module Operation
end # module Veritas
