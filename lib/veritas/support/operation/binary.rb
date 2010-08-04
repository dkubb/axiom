module Veritas
  module Operation
    module Binary
      include Immutable, Optimizable

      attr_reader :left, :right

      def initialize(left, right)
        @left, @right = left, right
      end

      def optimized?
        optimize_left.equal?(left) && optimize_right.equal?(right)
      end

      def eql?(other)
        instance_of?(other.class) &&
        left.eql?(other.left)     &&
        right.eql?(other.right)
      end

      def hash
        left.hash ^ right.hash
      end

    private

      def optimize_left
        left = self.left
        left.respond_to?(:optimize) ? left.optimize : left
      end

      def optimize_right
        right = self.right
        right.respond_to?(:optimize) ? right.optimize : right
      end

    end # module Binary
  end # module Operation
end # module Veritas
