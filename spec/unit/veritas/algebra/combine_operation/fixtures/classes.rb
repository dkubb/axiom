module CombineOperationSpecs
  class Object
    include Veritas::Algebra::CombineOperation

    class Set
      def initialize(header, left, right)
        @header, @left, @right = header, left, right
      end

      def each
        @left.each  { |tuple| yield tuple.project(@header) }
        @right.each { |tuple| yield tuple.project(@header) }
        self
      end
    end
  end
end
