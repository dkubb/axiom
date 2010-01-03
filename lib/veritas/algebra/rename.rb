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
        @body ||= relation.body.class.new(header, relation.body)
      end

    end # class Rename
  end # module Algebra
end # module Veritas
