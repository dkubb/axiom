module Veritas
  module Algebra
    class Projection < Relation
      include Relation::Operation::Unary

      def initialize(operand, attributes)
        super(operand)
        @header     = operand.header.project(attributes.to_ary)
        @directions = operand.directions.project(@header)
        @predicate  = operand.predicate.project(@header) || Logic::Proposition::True.instance
      end

      def each
        seen = {}
        operand.each do |tuple|
          tuple = tuple.project(header)
          yield(seen[tuple] = tuple) unless seen.key?(tuple)
        end
        self
      end

      def optimize
        return drop_current_projection if header_unchanged?

        case optimize_operand
          when Relation::Empty          then new_empty_relation
          when self.class               then drop_contained_projection
          when Relation::Operation::Set then wrap_with_operation
          else
            super
        end
      end

      def wrap(header)
        self.class.new(yield(optimize_operand), header)
      end

    private

      def header_unchanged?
        optimize_operand.header.to_a == header.to_a
      end

      def new(operand)
        self.class.new(operand, header)
      end

      def drop_current_projection
        optimize_operand
      end

      def drop_contained_projection
        new(optimize_operand.operand)
      end

      def wrap_with_operation
        optimize_operand.wrap { |relation| new(relation) }.optimize
      end

      memoize :optimize

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

        def project_relation(operand, attributes = header)
          Projection.new(operand, attributes)
        end

      end # module Methods

      Relation.class_eval { include Methods }

    end # class Projection
  end # module Algebra
end # module Veritas
