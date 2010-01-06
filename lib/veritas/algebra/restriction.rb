module Veritas
  module Algebra
    class Restriction < Relation
      attr_reader :relation

      def initialize(relation, conditions = nil)
        @relation   = relation
        @conditions = conditions || yield(relation)
      end

      def header
        @header ||= relation.header
      end

      def body
        @body ||= restrict_body
      end

    private

      def restrict_body
        body = relation.select { |tuple| @conditions.call(tuple) }
        Body.new(header, body)
      end

    end # class Restriction
  end # module Algebra
end # module Veritas

require 'veritas/algebra/restriction/connective'
require 'veritas/algebra/restriction/predicate'
