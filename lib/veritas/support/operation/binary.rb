module Veritas
  module Operation
    module Binary
      attr_reader :left, :right

      def initialize(left, right)
        @left, @right = left, right
      end

    end # module Binary
  end # module Operation
end # module Veritas
