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

      end # class Offset
    end # module Operation
  end # class Relation
end # module Veritas
