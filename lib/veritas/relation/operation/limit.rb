module Veritas
  class Relation
    module Operation
      class Limit < Relation
        include Unary

        def self.new(relation, limit)
          if relation.directions.empty?
            raise OrderedRelationRequiredError, 'can only limit an ordered relation'
          end

          super
        end

        def initialize(relation, limit)
          @limit = limit.to_int
          super(relation)
        end

        def each
          relation.each_with_index do |tuple, index|
            break if @limit == index
            yield tuple
          end
          self
        end

        def optimize
          case optimize_relation
            when Limit then optimize_limit
            else
              super
          end
        end

        def to_i
          @limit
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

        def optimize_limit
          limit = optimize_relation
          if to_i == limit.to_i
            drop_no_op_limit
          else
            use_smallest_limit
          end
        end

        def drop_no_op_limit
          optimize_relation
        end

        def use_smallest_limit
          limit = optimize_relation
          self.class.new(limit.relation, [ to_i, limit.to_i ].min)
        end

      end # class Limit
    end # module Operation
  end # class Relation
end # module Veritas
