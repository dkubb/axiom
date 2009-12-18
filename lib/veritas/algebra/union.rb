module Veritas
  module Algebra
    class Union < Relation
      def initialize(left, right)
        @left, @right = left, right
      end

      def header
        @header ||= @left.header
      end

      def body
        @body ||= @left.body | @right.body
      end
    end # class Union
  end # module # Algebra
end # module Veritas
