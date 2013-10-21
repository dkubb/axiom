# encoding: utf-8

module Axiom
  class Attribute

    # Represents a tuple value in a relation tuple
    class Tuple < Object
      include Equalizer.new(:name, :header)

      # The header
      #
      # @return [Header]
      #
      # @api private
      attr_reader :header

      # Initialize a Tuple Attribute
      #
      # @param [#to_sym] _name
      #   the attribute name
      # @param [Hash] options
      #   the options for the attribute
      # @option options [Boolean] :required (true)
      #   if true, then the value cannot be nil
      # @option options [Header] :header
      #   the header for the tuple
      #
      # @return [undefined]
      #
      # @api private
      def initialize(_name, options)
        super
        @header = Axiom::Relation::Header.coerce(options.fetch(:header))
      end

      # The attribute type
      #
      # @example
      #   type = Axiom::Attribute::Tuple.type  # => Axiom::Types::Tuple
      #
      # @return [Class<Types::Tuple>]
      #
      # @api public
      def self.type
        Types::Tuple
      end

    end # class Tuple
  end # class Attribute
end # module Axiom
