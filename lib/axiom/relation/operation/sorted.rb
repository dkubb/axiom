# encoding: utf-8

module Axiom
  class Relation
    module Operation

      # A class representing a sorted relation
      class Sorted < Relation
        include Unary
        include Equalizer.new(:operand, :directions)

        # The relation sort order
        #
        # @return [Operation::Sorted::DirectionSet]
        #
        # @api private
        attr_reader :directions

        # Instantiate a new Sorted
        #
        # @example
        #   sorted = Sorted.new(operand, directions)
        #
        # @param [Relation] operand
        #   the relation to sort
        # @param [DirectionSet, Header, Array<Direction, Attribute>] directions
        #   the directions to sort tuples in
        #
        # @return [Sorted]
        #
        # @api public
        def self.new(operand, directions)
          header     = operand.header
          directions = DirectionSet.coerce(directions) do |direction|
            header[direction] unless direction.kind_of?(Direction)
          end
          new_directions = directions | header - directions.attributes
          directions     = new_directions if new_directions != directions
          super
        end

        # Initialize an Sorted
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
        #   sorted = Sorted.new(operand, directions)
        #   sorted.each { |tuple| ... }
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

        # Insert a relation into the Sorted
        #
        # @example
        #   new_relation = sorted.insert(other)
        #
        # @param [Relation] other
        #
        # @return [Sorted]
        #
        # @api public
        def insert(other)
          assert_matching_directions(other, INSERTED)
          operand.insert(other.operand).sort_by(directions)
        end

        # Delete a relation from the Sorted
        #
        # @example
        #   new_relation = sorted.delete(other)
        #
        # @param [Relation] other
        #
        # @return [Sorted]
        #
        # @api public
        def delete(other)
          assert_matching_directions(other, DELETED)
          operand.delete(other.operand).sort_by(directions)
        end

        def to_ast
          s(:sorted, operand.to_ast, directions.to_ast)
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
        # @raise [SortedMismatchError]
        #   raised when inserting a relation does not have matching directions
        #
        # @api private
        def assert_matching_directions(other, event)
          unless other.respond_to?(:directions) && directions.eql?(other.directions)
            fail SortedMismatchError, "other relation must have matching directions to be #{event}"
          end
        end

        module Methods

          # Return a sorted relation
          #
          # @example with a block
          #   sorted = relation.sort_by { |r| [r.a.desc, r.b] }
          #
          # @example with directions
          #   sorted = relation.sort_by(directions)
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
          # @return [Sorted]
          #
          # @api public
          def sort_by(*args, &block)
            Sorted.new(self, coerce_to_directions(*args, &block))
          end

          # Return a sorted relation
          #
          # @example
          #   sorted = relation.sort
          #
          # @return [Sorted]
          #
          # @api public
          def sort
            Sorted.new(self, nil)
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
          def coerce_to_directions(directions = Undefined, &block)
            if directions.equal?(Undefined)
              header.context(&block).yield
            else
              directions
            end
          end

        end # module Methods

        Relation.class_eval { include Methods }

      end # class Sorted
    end # module Operation
  end # class Relation
end # module Axiom
