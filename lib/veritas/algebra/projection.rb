module Veritas
  module Algebra
    class Projection < Relation
      include Relation::Operation::Unary

      def initialize(operand, attributes)
        super(operand)
        @header     = @header.project(attributes.to_ary)
        @directions = @directions.project(@header)
      end

      def each
        seen = {}
        operand.each do |tuple|
          tuple = tuple.project(header)
          yield(seen[tuple] = tuple) unless seen.key?(tuple)
        end
        self
      end

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
