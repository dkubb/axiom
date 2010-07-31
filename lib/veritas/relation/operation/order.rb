module Veritas
  class Relation
    module Operation
      class Order < Relation
        include Unary

        def self.new(operand, directions)
          directions = DirectionSet.new(directions)
          assert_order_by_full_header(operand, directions)
          super
        end

        class << self
        private

          def assert_order_by_full_header(operand, directions)
            if operand.header.to_set != directions.attributes.to_set
              raise InvalidDirectionsError, 'directions must include every attribute in the header'
            end
          end

        end

        def initialize(operand, directions)
          super(operand)
          @directions = directions
        end

        def each(&block)
          directions.sort_tuples(operand).each(&block)
          self
        end

        def optimize
          operand = optimize_operand
          if operand.kind_of?(Order)
            drop_no_op_order
          elsif operand.kind_of?(Limit) && operand.to_i == 1
            drop_current_order
          else
            super
          end
        end

        def wrap(directions = self.directions)
          new(yield(optimize_operand), directions)
        end

        def eql?(other)
          instance_of?(other.class)         &&
          directions.eql?(other.directions) &&
          operand.eql?(other.operand)
        end

      private

        def new(operand, directions)
          self.class.new(operand, directions)
        end

        def new_optimized_operation
          new(optimize_operand, directions)
        end

        def drop_current_order
          optimize_operand
        end

        def drop_no_op_order
          order = optimize_operand
          order.class.new(order.operand, directions)
        end

        memoize :optimize

        module Methods
          def order(directions = yield(self))
            Operation::Order.new(self, directions)
          end

        end # module Methods

        Relation.class_eval { include Methods }

      end # class Order
    end # module Operation
  end # class Relation
end # module Veritas

require 'veritas/relation/operation/order/direction'
require 'veritas/relation/operation/order/direction_set'
