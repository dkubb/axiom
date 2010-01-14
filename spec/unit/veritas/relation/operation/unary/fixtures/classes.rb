module UnaryOperationSpecs
  class Object
    include Veritas::Relation::Operation::Unary

    class Body < Relation::Body
      attr_reader :header

      def initialize(tuples, header)
        @tuples, @header = tuples, header
      end

      def each(&block)
        @tuples.each(&block)
        self
      end
    end
  end
end
