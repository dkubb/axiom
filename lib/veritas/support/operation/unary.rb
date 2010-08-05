module Veritas
  module Operation
    module Unary
      include Immutable, Optimizable

      attr_reader :operand

      def initialize(operand)
        @operand = operand
      end

      def optimized?
        optimize_operand.equal?(operand)
      end

      def new_optimized_operation
        new(optimize_operand)
      end

      def eql?(other)
        instance_of?(other.class) &&
        operand.eql?(other.operand)
      end

      def hash
        operand.hash
      end

    private

      def optimize_operand
        operand = self.operand
        operand.respond_to?(:optimize) ? operand.optimize : operand
      end

    end # module Unary
  end # module Operation
end # module Veritas
