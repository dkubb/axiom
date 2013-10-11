# encoding: utf-8

module Axiom
  class Attribute

    # Represents a Relation value in a relation tuple
    class Relation < Object
      include Equalizer.new(:name, :header)

      # The tuple header
      #
      # @return [Header]
      #
      # @api private
      attr_reader :header

      # Initialize a Relation Attribute
      #
      # @param [#to_sym] _name
      #   the attribute name
      # @param [Hash] options
      #   the options for the attribute
      # @option options [Boolean] :required (true)
      #   if true, then the value cannot be nil
      # @option options [Header] :header
      #   the header for the relation
      #
      # @return [undefined]
      #
      # @api private
      def initialize(_name, options = EMPTY_HASH)
        super
        @header = Axiom::Relation::Header.coerce(options.fetch(:header))
      end

      # The attribute type
      #
      # @example
      #   type = Axiom::Attribute::Relation.type  # => Axiom::Types::Relation
      #
      # @return [Class<Types::Relation>]
      #
      # @api public
      def self.type
        Types::Relation
      end

      # Initialize a new relation with the tuples provided
      #
      # @example
      #   relation = attribute.new_relation(tuples)
      #
      # @param [Enumerable] tuples
      #
      # @return [Relation]
      #
      # @api public
      def new_relation(tuples)
        type.primitive.new(@header, tuples)
      end

    end # class Relation
  end # class Attribute
end # module Axiom
