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
        relation = optimize_relation

        # drop the current projection if the headers and order are the same
        return relation if relation.header.to_a == header.to_a

        case relation
          when Relation::Empty          then new_empty_relation
          when self.class               then optimize_projection(relation)
          when Relation::Operation::Set then optimize_set(relation)
          else
            super
        end
      end

    private

      def new(relation)
        self.class.new(relation, header)
      end

      def new_optimized_operation
        new(optimize_relation)
      end

      def optimize_projection(other)
        # drop the inner projection
        new(other.relation)
      end

      def optimize_set(set)
        # push projections before the set operation
        set.class.new(new(set.left), new(set.right))
      end

    end # class Projection
  end # module Algebra
end # module Veritas
