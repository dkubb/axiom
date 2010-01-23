module Veritas
  module Algebra
    class Restriction < Relation
      include Relation::Operation::Unary

      attr_reader :predicate

      def initialize(relation, predicate)
        @predicate = predicate
        super(relation)
      end

      def each
        relation.each { |tuple| yield(tuple) if predicate.call(tuple) }
        self
      end

      def optimize
        relation = optimize_relation

        return relation           if matches_all?
        return new_empty_relation if matches_none?

        case relation
          when self.class                   then optimize_restriction(relation)
          when Relation::Operation::Set     then optimize_set(relation)
          when Relation::Operation::Reverse then optimize_reverse(relation)
          when Relation::Operation::Order   then optimize_order(relation)
          else
            super
        end
      end

    private

      def new(relation)
        self.class.new(relation, optimize_predicate)
      end

      def new_optimized_operation
        new(optimize_relation)
      end

      def optimized?
        super || !optimize_predicate.equal?(predicate)
      end

      def matches_all?
        optimize_predicate.kind_of?(True)
      end

      def matches_none?
        optimize_predicate.kind_of?(False)
      end

      def optimize_predicate
        @optimize_predicate ||= predicate.optimize
      end

      def optimize_restriction(other)
        # combine restrictions
        other.class.new(
          other.relation,
          (other.predicate & predicate).optimize
        )
      end

      def optimize_set(set)
        # push restrictions down to each relation in the set operation
        set.class.new(new(set.left), new(set.right))
      end

      def optimize_reverse(reverse)
        # push the restrictions down before the reverse
        reverse.class.new(new(reverse.relation))
      end

      def optimize_order(order)
        # push the restrictions down before the order
        order.class.new(new(order.relation), directions)
      end

    end # class Restriction
  end # module Algebra
end # module Veritas

require 'veritas/algebra/restriction/connective'
require 'veritas/algebra/restriction/predicate'
require 'veritas/algebra/restriction/proposition'
