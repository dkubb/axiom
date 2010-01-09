module Veritas
  module Algebra
    class Project < Relation
      attr_reader :relation

      def initialize(relation, attributes)
        @relation, @attributes = relation, attributes.to_ary
      end

      def header
        @header ||= project_header
      end

      def body
        @body ||= relation.body.project(header)
      end

    private

      def project_header
        header = relation.header
        header.class.new(header.project(@attributes))
      end

    end # class Project
  end # module Algebra
end # module Veritas
