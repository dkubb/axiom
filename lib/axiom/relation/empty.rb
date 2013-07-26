# encoding: utf-8

module Axiom
  class Relation

    # An empty relation
    class Empty < Materialized

      # Initialize an empty Relation
      #
      # @param [Header] header
      #   the header for the empty relation
      #
      # @return [undefined]
      #
      # @api public
      def initialize(header)
        super(header, ZERO_TUPLE)
      end

    end # class Empty
  end # class Relation
end # module Axiom
