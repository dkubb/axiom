module Veritas
  module Algebra
    class Projection < Relation
      attr_reader :relation

      def initialize(relation, attributes)
        @relation, @attributes = relation, attributes.to_ary
      end

      def header
        @header ||= relation.header.project(@attributes)
      end

      def body
        @body ||= relation.body.project(header)
      end

    end # class Projection
  end # module Algebra
end # module Veritas
