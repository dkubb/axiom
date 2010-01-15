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

      end # class Limit
    end # module Operation
  end # class Relation
end # module Veritas
