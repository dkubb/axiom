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
          when self.class                   then combine_restrictions
          when Relation::Operation::Set     then move_before_set
          when Relation::Operation::Reverse then move_before_reverse
          when Relation::Operation::Order   then move_before_order
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

      def combine_restrictions
        restriction = optimize_relation
        restriction.class.new(
          restriction.relation,
          (restriction.predicate & predicate).optimize
        )
      end

      def move_before_set
        set = optimize_relation
        set.class.new(new(set.left), new(set.right))
      end

      def move_before_reverse
        reverse = optimize_relation
        reverse.class.new(new(reverse.relation))
      end

      def move_before_order
        order = optimize_relation
        order.class.new(new(order.relation), directions)
      end

    end # class Restriction
  end # module Algebra
end # module Veritas

require 'veritas/algebra/restriction/connective'
require 'veritas/algebra/restriction/predicate'
require 'veritas/algebra/restriction/proposition'
