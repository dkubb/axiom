module Veritas
  class Relation
    module Operation
      class Order < Relation
        include Unary

        attr_reader :directions

        def self.new(relation, directions)
          directions = DirectionSet.new(directions)

          if relation.header.to_set != directions.attributes.to_set
            raise ArgumentError, 'directions must include every attribute in the header'
          end

          super
        end

        def initialize(relation, directions)
          @directions = directions
          super(relation)
        end

        def each(&block)
          directions.sort(relation).each(&block)
          self
        end

      end # class Order
    end # module Operation
  end # class Relation
end # module Veritas

require 'veritas/relation/operation/order/direction'
require 'veritas/relation/operation/order/direction_set'
