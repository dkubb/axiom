module Veritas
  module Algebra
    class Restriction < Relation
      include Relation::Operation::Unary

      def initialize(relation, predicate)
        @predicate = relation.predicate & predicate
        super(relation)
      end

      def each
        relation.each { |tuple| yield(tuple) if predicate.call(tuple) }
        self
      end

      def optimize
        relation = optimize_relation

        return relation           if matches_all? || relation.kind_of?(Relation::Empty)
        return new_empty_relation if matches_none?

        case relation
          when self.class                   then combine_restrictions
          when Relation::Operation::Set,
               Relation::Operation::Reverse then wrap_with_operation
          when Relation::Operation::Order   then wrap_with_order
          else
            super
        end
      end

      def wrap
        self.class.new(yield(relation), predicate)
      end

      def eql?(other)
        instance_of?(other.class)       &&
        predicate.eql?(other.predicate) &&
        relation.eql?(other.relation)
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
        predicate   = restriction.predicate & optimize_predicate
        self.class.new(restriction.relation, predicate).optimize
      end

      def wrap_with_operation
        optimize_relation.wrap { |relation| new(relation) }.optimize
      end

      def wrap_with_order
        optimize_relation.wrap(directions) { |relation| new(relation) }.optimize
      end

    end # class Restriction
  end # module Algebra
end # module Veritas

require 'veritas/algebra/restriction/expression'

require 'veritas/algebra/restriction/connective'
require 'veritas/algebra/restriction/predicate'
require 'veritas/algebra/restriction/proposition'
