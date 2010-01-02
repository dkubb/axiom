module Veritas
  module Algebra
    module BinaryOperation
      attr_reader :left, :right

      def initialize(left, right)
        @left, @right = left, right
      end

    end # module BinaryOperation
  end # module Algebra
end # module Veritas
