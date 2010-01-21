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

      def optimize
        relation = self.relation.optimize

        # only optimize if the header attributes and order is the same
        if relation.header.to_a == header.to_a
          relation
        elsif relation.kind_of?(Relation::Empty)
          new_empty_relation
        else
          super
        end
      end

    end # class Projection
  end # module Algebra
end # module Veritas
