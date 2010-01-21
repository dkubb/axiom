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
        relation  = self.relation.optimize
        predicate = self.predicate.optimize

        if predicate.kind_of?(True) || relation.kind_of?(Relation::Empty)
          relation
        elsif predicate.kind_of?(False)
          Relation.new(relation.header, [])
        else
          super
        end
      end

    end # class Restriction
  end # module Algebra
end # module Veritas

require 'veritas/algebra/restriction/connective'
require 'veritas/algebra/restriction/predicate'
require 'veritas/algebra/restriction/proposition'
