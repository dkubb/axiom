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
          relation = optimize_relation

          case relation
            when Reverse then optimize_reverse(relation)
            else
              super
          end
        end

      private

        def new_optimized_operation
          self.class.new(optimize_relation)
        end

        def optimize_reverse(other)
          # drop the current operation
          other.relation
        end

      end # class Limit
    end # module Operation
  end # class Relation
end # module Veritas
