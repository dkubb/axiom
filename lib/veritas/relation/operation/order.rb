module Veritas
  class Relation
    module Operation
      class Order < Relation
        include Unary

        attr_reader :directions

        def self.new(relation, directions)
          directions = DirectionSet.new(directions)
          assert_order_by_full_header(relation, directions)
          super
        end

        class << self
        private

          def assert_order_by_full_header(relation, directions)
            if relation.header.to_set != directions.attributes.to_set
              raise InvalidDirectionsError, 'directions must include every attribute in the header'
            end
          end

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
          relation = optimize_relation
          if relation.kind_of?(Order)
            drop_no_op_order
          elsif relation.kind_of?(Limit) && relation.to_i == 1
            drop_current_order
          else
            super
          end
        end

        def wrap(directions)
          self.class.new(yield(relation), directions)
        end

        def eql?(other)
          instance_of?(other.class)         &&
          directions.eql?(other.directions) &&
          relation.eql?(other.relation)
        end

      private

        def new_optimized_operation
          self.class.new(optimize_relation, directions)
        end

        def drop_current_order
          optimize_relation
        end

        def drop_no_op_order
          order = optimize_relation
          order.class.new(order.relation, directions)
        end

        memoize :new_optimized_operation, :drop_no_op_order

        module Methods
          include Immutable

          def order(directions = yield(self))
            Operation::Order.new(self, directions)
          end

          def directions
            Operation::Order::DirectionSet.new([])
          end

          memoize :directions

        end # module Methods

        Relation.class_eval { include Methods }

      end # class Order
    end # module Operation
  end # class Relation
end # module Veritas

require 'veritas/relation/operation/order/direction'
require 'veritas/relation/operation/order/direction_set'
