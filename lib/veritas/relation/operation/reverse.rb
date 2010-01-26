module Veritas
  class Relation
    module Operation
      class Reverse < Order
        def self.new(relation)
          directions = relation.directions
          if directions.empty?
            raise OrderedRelationRequiredError, 'can only reverse an ordered relation'
          end

          super(relation, directions.reverse)
        end

        def each(&block)
          relation.reverse_each(&block)
          self
        end

        def optimize
          case optimize_relation
            when Reverse then drop_no_op_reverse
            else
              super
          end
        end

      private

        def new_optimized_operation
          self.class.new(optimize_relation)
        end

        def drop_no_op_reverse
          optimize_relation.relation
        end

      end # class Limit
    end # module Operation
  end # class Relation
end # module Veritas
