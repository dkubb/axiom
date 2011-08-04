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
      #
      # @return [undefined]
      #
      # @api public
      def initialize(header, tuples = ZERO_TUPLE)
        super
      end

      # Test if there are no tuples
      #
      # @example
      #   empty.empty?  # => true
      #
      # @return [true]
      #
      # @api public
      def empty?
        true
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
