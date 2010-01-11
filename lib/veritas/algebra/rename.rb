module Veritas
  module Algebra
    class Rename < Relation
      attr_reader :relation

      def initialize(relation, aliases)
        @relation, @aliases = relation, aliases
      end

      def header
        @header ||= relation.header.rename(@aliases)
      end

      def body
        @body ||= rename_body
      end

    private

      def rename_body
        body = relation.body
        body.class.new(header, body)
      end

    end # class Rename
  end # module Algebra
end # module Veritas
