module Veritas
  module Algebra
    class Projection < Relation
      include Relation::Operation::Unary

      def initialize(relation, attributes)
        super(relation)
        @attributes = attributes.to_ary
      end

      def header
        relation.header.project(@attributes)
      end

      def each
        seen = {}
        relation.each do |tuple|
          tuple = tuple.project(header)
          yield(seen[tuple] = tuple) unless seen.key?(tuple)
        end
        self
      end

      def directions
        relation.directions.project(header)
      end

      def predicate
        relation.predicate.project(header) || Logic::Proposition::True.instance
      end

      def optimize
        return drop_current_projection if header_unchanged?

        case optimize_relation
          when Relation::Empty          then new_empty_relation
          when self.class               then drop_contained_projection
          when Relation::Operation::Set then wrap_with_operation
          else
            super
        end
      end

      def wrap(header)
        self.class.new(yield(relation), header)
      end

    private

      def header_unchanged?
        optimize_relation.header.to_a == header.to_a
      end

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

      def wrap_with_operation
        optimize_relation.wrap { |relation| new(relation) }.optimize
      end

      memoize :header, :directions, :predicate, :optimize

      module Methods
        def project(attributes)
          project_relation(self, attributes)
        end

        def remove(attributes)
          project(header - project_header(attributes))
        end

      private

        def project_header(attributes)
          header.project(attributes)
        end

        def project_relation(relation, attributes = header)
          Projection.new(relation, attributes)
        end

      end # module Methods

      Relation.class_eval { include Methods }

    end # class Projection
  end # module Algebra
end # module Veritas
