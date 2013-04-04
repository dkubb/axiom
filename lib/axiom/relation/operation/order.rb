# encoding: utf-8

module Axiom
  class Relation
    module Operation

      # A class representing a sorted relation
      class Order < Relation
        include Unary
        include Equalizer.new(:operand, :directions)

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
          if operand.header != directions.attributes
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

        # Insert a relation into the Order
        #
        # @example
        #   new_relation = order.insert(other)
        #
        # @param [Relation] other
        #
        # @return [Order]
        #
        # @api public
        def insert(other)
          assert_matching_directions(other, INSERTED)
          operand.insert(other.operand).sort_by(directions)
        end

        # Delete a relation from the Order
        #
        # @example
        #   new_relation = order.delete(other)
        #
        # @param [Relation] other
        #
        # @return [Order]
        #
        # @api public
        def delete(other)
          assert_matching_directions(other, DELETED)
          operand.delete(other.operand).sort_by(directions)
        end

      private

        # Assert that the other relation has matching directions
        #
        # @param [Relation] other
        #
        # @param [String] event
        #
        # @return [undefined]
        #
        # @raise [OrderMismatchError]
        #   raised when inserting a relation does not have matching directions
        #
        # @api private
        def assert_matching_directions(other, event)
          unless other.kind_of?(self.class) && directions.eql?(other.directions)
            raise OrderMismatchError, "other relation must have matching directions to be #{event}"
          end
        end

        module Methods

          # Return an ordered relation
          #
          # @example with a block
          #   order = relation.sort_by { |r| [ r.a.desc, r.b ] }
          #
          # @example with directions
          #   order = relation.sort_by(directions)
          #
          # @param [Array] args
          #   optional arguments
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
          def sort_by(*args, &block)
            Order.new(self, coerce_to_directions(*args, &block))
          end

        private

          # Coerce the arguments and block into directions
          #
          # @param [DirectionSet, Array<Direction>, Header] directions
          #   optional directions
          #
          # @yield [relation]
          #   optional block to evaluate for directions
          #
          # @yieldparam [Relation] relation
          #
          # @yieldreturn [DirectionSet, Array<Direction>, Header]
          #
          # @return [DirectionSet, Array<Direction>, Header]
          #
          # @api private
          def coerce_to_directions(directions = Undefined)
            if directions.equal?(Undefined)
              Evaluator::Context.new(header) { |context| yield context }.yield
            else
              directions
            end
          end

        end # module Methods

        Relation.class_eval { include Methods }

      end # class Order
    end # module Operation
  end # class Relation
end # module Axiom
