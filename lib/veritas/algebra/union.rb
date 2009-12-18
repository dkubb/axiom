module Veritas
  module Algebra
    class Union < Relation
      def self.new(left, right)
        unless left.header == right.header
          raise HeaderMismatchError, 'the headers must be equivalent to be unioned'
        end

        super
      end

      def initialize(left, right)
        @left, @right = left, right

        @header = @left.header
        @body   = @left.body | @right.body
      end
    end # class Union
  end # module # Algebra
end # module Veritas
