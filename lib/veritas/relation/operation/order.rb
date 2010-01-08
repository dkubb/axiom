module Veritas
  class Relation
    module Operation
      class Order
        attr_reader :relation, :directions

        def self.new(relation, directions)
          # TODO: create an object to encapsulate an OrderedSet of Direction objects
          directions = directions.map do |direction|
            direction.respond_to?(:asc) ? direction.asc : direction
          end

          header = relation.header
          unless header == (header & directions.map { |direction| direction.attribute })
            raise ArgumentError, 'directions must include every attribute in the header'
          end

          super(relation, directions)
        end

        def initialize(relation, directions)
          @relation, @directions = relation, directions
        end

        def header
          @header ||= relation.header
        end

        def body
          @body ||= order_body
        end

      private

        def order_body
          body = relation.body.sort { |left, right| cmp_tuples(left, right) }
          Body.new(header, body)
        end

        # TODO: move this logic into the DirectionSet object
        def cmp_tuples(left, right)
          directions.each do |direction|
            cmp = direction.call(left, right)
            return cmp if cmp != 0
          end
        end

      end # class Order
    end # module Operation
  end # class Relation
end # module Veritas


require 'veritas/relation/operation/order/direction'
require 'veritas/relation/operation/order/body'
