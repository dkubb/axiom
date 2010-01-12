module SetOperationSpecs
  class Object
    include Veritas::Algebra::SetOperation

    class Set
      def initialize(left, right)
        @left, @right = left, right
      end

      def each(&block)
        @left.each(&block)
        @right.each(&block)
        self
      end
    end
  end
end
