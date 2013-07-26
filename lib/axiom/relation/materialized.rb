# encoding: utf-8

module Axiom
  class Relation

    # A materialized relation
    class Materialized < Relation
      ZERO_TUPLE = EMPTY_ARRAY

      # The relation sort order
      #
      # @return [Operation::Order::DirectionSet]
      #
      # @api private
      attr_reader :directions

      # Initialize a materialized Relation
      #
      # @param [Header, #to_ary] header
      #   the relation header
      # @param [Enumerable] tuples
      #   the relation tuples
      # @param [Operation::Order::DirectionSet] directions
      #   optional directions to sort the relation by
      #
      # @return [undefined]
      #
      # @api private
      def initialize(header, tuples = ZERO_TUPLE, directions = Operation::Order::DirectionSet::EMPTY)
        super(header, tuples)
        @directions = Operation::Order::DirectionSet.coerce(directions)
      end

      # A noop for Materialized relations
      #
      # @example
      #   materialized.materialize  # (Always returns self)
      #
      # @return [self]
      #
      # @api public
      def materialize
        self
      end

      # Return true for a Materialized relation
      #
      # @example
      #   relation.materialized?  # => true
      #
      # @return [true]
      #
      # @api public
      def materialized?
        true
      end

      # Return the number of tuples
      #
      # @example
      #   materialized.size  # => 10
      #
      # @return [Integer]
      #
      # @api public
      def size
        tuples.size
      end

    end # class Materialized
  end # class Relation
end # module Axiom
