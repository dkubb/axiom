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
          return drop_current_offset if to_i == 0

          case optimize_relation
            when Offset then use_offset_sum
            else
              super
          end
        end

        def to_i
          @offset
        end

        def eql?(other)
          instance_of?(other.class) &&
          to_i.eql?(other.to_i)     &&
          relation.eql?(other.relation)
        end

      private

        def new_optimized_operation
          self.class.new(optimize_relation, to_i)
        end

        def drop_current_offset
          optimize_relation
        end

        def use_offset_sum
          offset = optimize_relation
          self.class.new(offset.relation, to_i + offset.to_i)
        end

      end # class Offset
    end # module Operation
  end # class Relation
end # module Veritas
