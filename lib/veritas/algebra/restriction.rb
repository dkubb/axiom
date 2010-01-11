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
        @body ||= relation.body.restrict(predicate)
      end

    end # class Restriction
  end # module Algebra
end # module Veritas

require 'veritas/algebra/restriction/connective'
require 'veritas/algebra/restriction/predicate'
require 'veritas/algebra/restriction/set'
