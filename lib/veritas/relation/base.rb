# encoding: utf-8

module Veritas
  class Relation

    # A class that represents a base relation
    class Base < Relation

      # The base relation name
      #
      # @example
      #   name = base.name
      #
      # @return [#to_s]
      #
      # @api public
      attr_reader :name

      # Initialize a base relation
      #
      # @param [#to_s] name
      #   the relation name
      # @param [Header, #to_ary] header
      #   the relation header
      # @param [Enumerable] tuples
      #   the relation tuples
      #
      # @return [undefined]
      #
      # @api private
      def initialize(name, header, tuples = Empty::ZERO_TUPLE)
        super(header, tuples)
        @name = Immutable.freeze_object(name.to_s)
      end

      # Return the hash of the base relation
      #
      # @example
      #   hash = base.hash
      #
      # @return [Fixnum]
      #
      # @api public
      def hash
        super ^ name.hash
      end

      memoize :hash

    end # class Base
  end # class Relation
end # module Veritas
