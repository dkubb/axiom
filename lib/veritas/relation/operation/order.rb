module Veritas
  class Relation
    module Operation
      class Order < Relation
        include Unary

        def self.new(operand, directions)
          directions = DirectionSet.coerce(directions)
          assert_order_by_full_header(operand, directions)
          super
        end

        def self.assert_order_by_full_header(operand, directions)
          if operand.header.to_set != directions.attributes.to_set
            raise InvalidDirectionsError, 'directions must include every attribute in the header'
          end
        end

        private_class_method :assert_order_by_full_header

        def initialize(operand, directions)
          super(operand)
          @directions = directions
        end

        def each(&block)
          directions.sort_tuples(operand).each(&block)
          self
        end

        def eql?(other)
          instance_of?(other.class)         &&
          directions.eql?(other.directions) &&
          operand.eql?(other.operand)
        end

      private

        module Methods
          def order(directions = block_given? ? yield(self) : header)
            Operation::Order.new(self, Array(directions))
          end

        end # module Methods

        Relation.class_eval { include Methods }

      end # class Order
    end # module Operation
  end # class Relation
end # module Veritas

require 'veritas/relation/operation/order/direction'
require 'veritas/relation/operation/order/direction_set'
