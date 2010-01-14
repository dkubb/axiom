module SetOperationSpecs
  class Object
    include Veritas::Relation::Operation::Set

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
