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
          directions.sort_tuples(relation).each(&block)
          self
        end

        def optimize
          relation = relation_optimize

          if relation.kind_of?(Order)
            merge_order(relation)
          else
            super
          end
        end

      private

        def new(relation)
          self.class.new(relation, directions)
        end

        def merge_order(other)
          Order.new(other.relation, directions)
        end

      end # class Order
    end # module Operation
  end # class Relation
end # module Veritas

require 'veritas/relation/operation/order/direction'
require 'veritas/relation/operation/order/direction_set'
