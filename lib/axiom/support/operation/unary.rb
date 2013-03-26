# encoding: utf-8

module Axiom
  module Operation
    module Unary
      include Equalizer.new(:operand)

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
        @operand = freeze_object(operand)
      end

    end # module Unary
  end # module Operation
end # module Axiom
