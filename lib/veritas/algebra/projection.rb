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

        return drop_current_projection if relation.header.to_a == header.to_a

        case relation
          when Relation::Empty          then new_empty_relation
          when self.class               then drop_contained_projection
          when Relation::Operation::Set then move_before_set
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

      def drop_current_projection
        optimize_relation
      end

      def drop_contained_projection
        new(optimize_relation.relation)
      end

      def move_before_set
        set = optimize_relation
        set.class.new(new(set.left), new(set.right)).optimize
      end

    end # class Projection
  end # module Algebra
end # module Veritas
