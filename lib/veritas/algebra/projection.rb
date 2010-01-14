module Veritas
  module Algebra
    class Projection < Relation
      include Relation::Operation::Unary

      def initialize(relation, attributes)
        @attributes = attributes.to_ary
        super(relation)
      end

      def header
        @header ||= relation.header.project(@attributes)
      end

      def each
        seen = {}
        relation.each do |tuple|
          tuple = tuple.project(header)
          yield(seen[tuple] = tuple) unless seen.key?(tuple)
        end
        self
      end

    end # class Projection
  end # module Algebra
end # module Veritas
