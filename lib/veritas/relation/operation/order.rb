# encoding: utf-8

module Veritas
  class Relation
    module Operation

      # A class representing a sorted relation
      class Order < Relation
        include Unary

        compare :operand, :directions

        # The relation sort order
        #
        # @return [Operation::Order::DirectionSet]
        #
        # @api private
        attr_reader :directions

        # Instantiate a new Order
        #
        # @example
        #   order = Order.new(operand, directions)
        #
        # @param [Relation] operand
        #   the relation to sort
        # @param [DirectionSet, Array<Direction, Attribute>] directions
        #   the directions to sort tuples in
        #
        # @return [Order]
        #
        # @api public
        def self.new(operand, directions)
          directions = DirectionSet.coerce(directions)
          assert_order_by_full_header(operand, directions)
          super
        end

        # Assert the full header is sorted on
        #
        # Sorting on the full header ensures deterministic results,
        # which is necessary for ordering to be useful.
        #
        # @param [Relation] operand
        # @param [#attributes] directions
        #
        # @return [undefined]
        #
        # @raise [InvalidDirectionsError]
        #   raised if the full header is not sorted on
        #
        # @api private
        def self.assert_order_by_full_header(operand, directions)
          if operand.header.to_set != directions.attributes.to_set
            raise InvalidDirectionsError, 'directions must include every attribute in the header'
          end
        end

        private_class_method :assert_order_by_full_header

        # Initialize an Order
        #
        # @param [Relation] operand
        #   the relation to sort
        # @param [DirectionSet, Array<Direction, Attribute>] directions
        #   the directions to sort tuples in
        #
        # @return [undefined]
        #
        # @api private
        def initialize(operand, directions)
          super(operand)
          @directions = directions
        end

        # Iterate over each tuple in the set
        #
        # @example
        #   order = Order.new(operand, directions)
        #   order.each { |tuple| ... }
        #
        # @yield [tuple]
        #
        # @yieldparam [Tuple] tuple
        #   each tuple in the set
        #
        # @return [self]
        #
        # @api public
        def each
          return to_enum unless block_given?
          directions.sort_tuples(operand).each { |tuple| yield tuple }
          self
        end

        module Methods

          # Return an ordered relation
          #
          # @example
          #   order = relation.sort_by { |r| [ r.a.desc, r.b ] }
          #
          # @yield [relation]
          #   optional block to evaluate for directions
          #
          # @yieldparam [Relation] relation
          #
          # @yieldreturn [DirectionSet, Array<Direction>, Header]
          #
          # @return [Order]
          #
          # @api public
          def sort_by
            context = Evaluator::Context.new(header) { |context| yield context }
            Order.new(self, context.yield)
          end

        end # module Methods

        Relation.class_eval { include Methods }

      end # class Order
    end # module Operation
  end # class Relation
end # module Veritas
