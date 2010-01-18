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

      end # class Limit
    end # module Operation
  end # class Relation
end # module Veritas
