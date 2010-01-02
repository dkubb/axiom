module Veritas
  module Algebra
    class Project < Relation
      attr_reader :relation

      def initialize(relation, attributes)
        @relation = relation
        @header   = Header.new(@relation.header.values_at(*attributes))
      end

      def body
        @body ||= relation.body.project(header)
      end

    end # class Project
  end # module Algebra
end # module Veritas
