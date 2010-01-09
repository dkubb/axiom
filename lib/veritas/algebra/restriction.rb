module Veritas
  module Algebra
    class Restriction < Relation
      attr_reader :relation, :predicate

      def initialize(relation, predicate)
        @relation, @predicate = relation, predicate
      end

      def header
        @header ||= relation.header
      end

      def body
        @body ||= restrict_body
      end

    private

      def restrict_body
        relation = self.relation
        body = relation.select { |tuple| predicate.call(tuple) }
        relation.body.class.new(header, body)
      end

    end # class Restriction
  end # module Algebra
end # module Veritas

require 'veritas/algebra/restriction/connective'
require 'veritas/algebra/restriction/predicate'
