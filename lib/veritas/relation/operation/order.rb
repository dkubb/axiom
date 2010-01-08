module Veritas
  class Relation
    module Operation
      class Order
        attr_reader :relation, :directions

        def initialize(relation, directions)
          @relation = relation

          # TODO: create an object to encapsulate an OrderedSet of Direction objects
          @directions = directions.map do |direction|
            direction.respond_to?(:asc) ? direction.asc : direction
          end
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

        # TODO: move this logic into the DirectionList object
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
