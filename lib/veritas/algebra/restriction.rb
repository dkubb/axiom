module Veritas
  module Algebra
    class Restriction < Relation
      attr_reader :relation, :predicate

      def initialize(relation, predicate = nil)
        @relation  = relation
        @predicate = predicate || yield(relation)
      end

      def header
        @header ||= relation.header
      end

      def body
        @body ||= restrict_body
      end

    private

      def restrict_body
        body = relation.select { |tuple| predicate.call(tuple) }
        Body.new(header, body)
      end

    end # class Restriction
  end # module Algebra
end # module Veritas

require 'veritas/algebra/restriction/connective'
require 'veritas/algebra/restriction/predicate'
