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
        relation, predicate = optimize_relation, optimize_predicate

        if predicate.kind_of?(True)
          relation
        elsif predicate.kind_of?(False)
          new_empty_relation
        elsif relation.kind_of?(self.class)
          relation.class.new(relation.relation, (relation.predicate & predicate).optimize)
        else
          super
        end
      end

    private

      def new_optimized_operation
        self.class.new(optimize_relation, optimize_predicate)
      end

      def optimized?
        super || !optimize_predicate.equal?(predicate)
      end

      def optimize_predicate
        @optimize_predicate ||= predicate.optimize
      end

    end # class Restriction
  end # module Algebra
end # module Veritas

require 'veritas/algebra/restriction/connective'
require 'veritas/algebra/restriction/predicate'
require 'veritas/algebra/restriction/proposition'
