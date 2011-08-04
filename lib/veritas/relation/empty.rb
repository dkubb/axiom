# encoding: utf-8

module Veritas
  class Relation

    # An empty relation
    class Empty < Materialized
      ZERO_TUPLE = [].freeze

      # Initialize an empty Relation
      #
      # @param [Header] header
      #   the header for the empty relation
      # @param [#each] tuples
      #   optional original tuples
      #
      # @return [undefined]
      #
      # @api public
      def initialize(header, tuples = ZERO_TUPLE)
        super
      end

      # Noop #each method
      #
      # @example
      #   empty = Empty.new(header)
      #   empty.each { ... }
      #
      # @return [self]
      #
      # @api public
      def each
        return to_enum unless block_given?
        self
      end

      # Return the number of tuples
      #
      # @example
      #   empty.size  # => 0
      #
      # @return [0]
      #
      # @api public
      def size
        0
      end

    end # class Empty
  end # class Relation
end # module Veritas
