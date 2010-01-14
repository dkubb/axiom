module Veritas
  module Algebra
    class Rename < Relation
      include Relation::Operation::Unary

      def initialize(relation, aliases)
        @aliases = aliases
        super(relation)
      end

      def header
        @header ||= relation.header.rename(@aliases)
      end

    end # class Rename
  end # module Algebra
end # module Veritas
