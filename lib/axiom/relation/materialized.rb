# encoding: utf-8

module Axiom
  class Relation

    # A materialized relation
    class Materialized < Relation
      ZERO_TUPLE = EMPTY_ARRAY

      # The relation sort order
      #
      # @return [Operation::Sorted::DirectionSet]
      #
      # @api private
      attr_reader :directions

      # Instantiate a materialized Relation
      #
      # @example of a materialized Array based relation
      #   array    = [[1], [2], [3]]
      #   relation = Relation::Materialized.new([[:id, Integer]], array)
      #
      # @example of a materialized Set based relation
      #   set      = Set[[1], [2], [3]]
      #   relation = Relation::Materialized.new([[:id, Integer]], set)
      #
      # @example of a materialized empty relation
      #   relation = Relation::Materialized.new([[:id, Integer]])
      #
      # @param [Array(Header, Enumerable)] args
      #
      # @return [Relation]
      #
      # @api public
      def self.new(*args)
        if equal?(Materialized) && empty?(args[1])
          Empty.new(args.first)
        else
          super
        end
      end

      # Test if the tuples are empty
      #
      # When tuples are nil, it means there are no tuples so it is the equivalent
      # of specifying [] for the tuples.
      #
      # @param [nil, #size] tuples
      #
      # @return [Boolean]
      #
      # @api private
      def self.empty?(tuples)
        tuples.nil? || begin
          size = tuples.size
          size && size.zero?
        end
      end
      private_class_method :empty?

      # Initialize a materialized Relation
      #
      # @param [Header, #to_ary] header
      #   the relation header
      # @param [Enumerable] tuples
      #   the relation tuples
      # @param [Operation::Sorted::DirectionSet] directions
      #   optional directions to sort the relation by
      #
      # @return [undefined]
      #
      # @api private
      def initialize(header, tuples, directions = Operation::Sorted::DirectionSet::EMPTY)
        super(header, tuples)
        @directions = Operation::Sorted::DirectionSet.coerce(directions)
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
