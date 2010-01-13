module SetOperationSpecs
  class Object
    include Veritas::Algebra::SetOperation

    class Body < Relation::Body
      def initialize(left, right)
        @left, @right = left, right
      end

      def header
        @header ||= @left.header
      end

      def each(&block)
        @left.each(&block)
        @right.each(&block)
        self
      end
    end
  end
end
