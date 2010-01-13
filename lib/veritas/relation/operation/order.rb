module Veritas
  class Relation
    module Operation
      class Order < Relation
        attr_reader :relation, :directions

        def self.new(relation, directions)
          directions = DirectionSet.new(directions)

          if relation.header.to_set != directions.attributes.to_set
            raise ArgumentError, 'directions must include every attribute in the header'
          end

          super
        end

        def initialize(relation, directions)
          @relation, @directions = relation, directions
        end

        def header
          @header ||= relation.header
        end

        def body
          @body ||= Body.new(relation.body, directions)
        end

      end # class Order
    end # module Operation
  end # class Relation
end # module Veritas

require 'veritas/relation/operation/order/direction'
require 'veritas/relation/operation/order/direction_set'
require 'veritas/relation/operation/order/body'
