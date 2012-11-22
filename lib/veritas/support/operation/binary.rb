# encoding: utf-8

module Veritas
  module Operation
    module Binary
      include Equalizer.new(:left, :right)

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
        @left  = freeze_object(left)
        @right = freeze_object(right)
      end

    end # module Binary
  end # module Operation
end # module Veritas
