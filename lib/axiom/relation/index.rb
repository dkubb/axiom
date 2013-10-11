# encoding: utf-8

module Axiom
  class Relation

    # Tuples keyed by a tuple
    class Index

      # Initialize an index
      #
      # @param [Header] key
      # @param [Header] header
      #
      # @return [undefined]
      #
      # @api private
      def initialize(key, header)
        @key    = key
        @header = header
        @index  = Hash.new { |hash, tuple| hash[tuple] = Set.new }
      end

      # Add a set of tuples to the index
      #
      # @example
      #   index.merge(tuples)
      #
      # @param [Enumerable<Tuple>] tuples
      #
      # @return [Index]
      #
      # @api public
      def merge(tuples)
        tuples.each(&method(:<<))
        self
      end

      # Add a tuple to the index
      #
      # @example
      #   index << tuple
      #
      # @param [Tuple]
      #
      # @return [Index]
      #
      # @api public
      def <<(tuple)
        self[tuple] << tuple.project(@header)
        self
      end

      # Iterate over each entry in the index
      #
      # @example
      #   index = Index.new(key_header, tuple_header)
      #   index.each { |key, tuples| ... }
      #
      # @yield [key, tuples]
      #
      # @yieldparam [Tuple] key
      #   the key for the tuples
      # @yieldparam [Set<Tuple>] tuples
      #   the indexed tuples
      #
      # @return [Index]
      #
      # @api public
      def each(&block)
        return to_enum unless block_given?
        @index.each(&block)
        self
      end

      # Return the tuples in the index based on the tuple key
      #
      # @example
      #   index[tuple]  # => tuples
      #
      # @param [Tuple] tuple
      #
      # @return [Set<Tuple>]
      #
      # @api public
      def [](tuple)
        @index[tuple.project(@key)]
      end

    end # class Index
  end # class Relation
end # module Axiom
