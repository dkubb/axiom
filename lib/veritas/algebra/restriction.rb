module Veritas
  module Algebra
    class Restriction < Relation
      include Relation::Operation::Unary

      attr_reader :predicate

      def initialize(operand, predicate)
        super(operand)
        @predicate = predicate
      end

      def each
        operand.each { |tuple| yield(tuple) if predicate.call(tuple) }
        self
      end

      def eql?(other)
        super && predicate.eql?(other.predicate)
      end

      module Methods
        def restrict(predicate = yield(self))
          Restriction.new(self, predicate)
        end

      end # module Methods

      Relation.class_eval { include Methods }

    end # class Restriction
  end # module Algebra
end # module Veritas
