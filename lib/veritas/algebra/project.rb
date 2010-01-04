module Veritas
  module Algebra
    class Project < Relation
      attr_reader :relation

      def initialize(relation, attributes)
        @relation, @attributes = relation, attributes.to_ary
      end

      def header
        @header ||= relation.header.class.new(relation.header.values_at(*@attributes))
      end

      def body
        @body ||= relation.body.project(header)
      end

    end # class Project
  end # module Algebra
end # module Veritas
