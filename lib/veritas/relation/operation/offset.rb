module Veritas
  class Relation
    module Operation
      class Offset < Relation
        include Unary

        def self.new(relation, offset)
          if relation.directions.empty?
            raise OrderedRelationRequiredError, 'can only offset an ordered relation'
          end

          super
        end

        def initialize(relation, offset)
          @offset = offset.to_int
          super(relation)
        end

        def each
          relation.each_with_index do |tuple, index|
            yield tuple if index >= @offset
          end
          self
        end

        def optimize
          relation = relation_optimize

          if relation.kind_of?(Offset)
            add_limit_operation(relation)
          else
            super
          end
        end

        def to_i
          @offset
        end

      private

        def new_optimized_operation
          self.class.new(relation_optimize, to_i)
        end

        def add_limit_operation(other)
          Offset.new(other.relation, to_i + other.to_i)
        end

      end # class Offset
    end # module Operation
  end # class Relation
end # module Veritas
