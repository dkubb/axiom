module Veritas
  module Algebra
    class Restriction < Relation
      include Relation::Operation::Unary

      def initialize(operand, predicate)
        super(operand)
        @predicate = operand.predicate & predicate
      end

      def each
        operand.each { |tuple| yield(tuple) if predicate.call(tuple) }
        self
      end

      def optimize
        operand = optimize_operand

        return operand            if matches_all? || operand.kind_of?(Relation::Empty)
        return new_empty_relation if matches_none?

        case operand
          when self.class                 then join_predicates
          when Relation::Operation::Set,
               Relation::Operation::Order then wrap_with_operation
          else
            super
        end
      end

      def wrap(predicate = optimize_predicate)
        new(yield(optimize_operand), predicate)
      end

      def eql?(other)
        instance_of?(other.class)       &&
        predicate.eql?(other.predicate) &&
        operand.eql?(other.operand)
      end

    private

      def new(operand, predicate = optimize_predicate)
        self.class.new(operand, predicate)
      end

      def new_optimized_operation
        new(optimize_operand, optimize_predicate)
      end

      def optimized?
        super && optimize_predicate.equal?(predicate)
      end

      def matches_all?
        optimize_predicate.kind_of?(Logic::Proposition::True)
      end

      def matches_none?
        optimize_predicate.kind_of?(Logic::Proposition::False)
      end

      def optimize_predicate
        predicate.optimize
      end

      def join_predicates
        restriction = optimize_operand
        predicate   = restriction.predicate & optimize_predicate
        self.class.new(restriction.operand, predicate).optimize
      end

      def wrap_with_operation
        optimize_operand.wrap { |relation| new(relation) }.optimize
      end

      memoize :optimize

      module Methods
        def restrict(predicate = yield(self))
          Restriction.new(self, predicate)
        end

      end # module Methods

      Relation.class_eval { include Methods }

    end # class Restriction
  end # module Algebra
end # module Veritas
