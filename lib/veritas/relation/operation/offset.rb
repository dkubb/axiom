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
          relation = optimize_relation

          case relation
            when Offset then optimize_offset(relation)
            else
              super
          end
        end

        def to_i
          @offset
        end

      private

        def new_optimized_operation
          self.class.new(optimize_relation, to_i)
        end

        def optimize_offset(other)
          # add the offsets together
          other.class.new(other.relation, to_i + other.to_i)
        end

      end # class Offset
    end # module Operation
  end # class Relation
end # module Veritas
