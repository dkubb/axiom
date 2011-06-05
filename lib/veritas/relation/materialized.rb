# encoding: utf-8

module Veritas
  class Relation

    # A materialized relation
    class Materialized < Relation

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
      def initialize(header, tuples, directions = Operation::Order::DirectionSet::EMPTY)
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

      # Test if there are no tuples
      #
      # @example
      #   materialized.empty?  # => true or false
      #
      # @return [Boolean]
      #
      # @api public
      def empty?
        tuples.empty?
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
end # module Veritas
