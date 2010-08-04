module Veritas
  module Operation
    module Unary
      include Immutable

      attr_reader :operand

      def initialize(operand)
        @operand = operand
      end

      def eql?(other)
        instance_of?(other.class) &&
        operand.eql?(other.operand)
      end

      def hash
        operand.hash
      end

    end # module Unary
  end # module Operation
end # module Veritas
