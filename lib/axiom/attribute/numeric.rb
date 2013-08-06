# encoding: utf-8

module Axiom
  class Attribute

    # Represents a Numeric value in a relation tuple
    class Numeric < Object
      include Comparable,
              Aggregate::Sum::Methods

      # The attribute type
      #
      # @example
      #   type = Axiom::Attribute::Numeric.type  # => Axiom::Types::Numeric
      #
      # @return [Class<Types::Numeric>]
      #
      # @api public
      def self.type
        Types::Numeric
      end

      # Initialize a Numeric Attribute
      #
      # @param [#to_sym] _name
      #   the attribute name
      # @param [#to_hash] options
      #   the options for the attribute
      # @option options [Boolean] :required (true)
      #   if true, then the value cannot be nil
      # @option options [Range<::Numeric>] :size
      #   The numeric range for a valid value
      #
      # @return [undefined]
      #
      # @api private
      def initialize(_name, options = EMPTY_HASH)
        super
        size = options[:size]
        if size
          @type = type.new do
            minimum(size.first)
            maximum(size.last)
          end
        end
      end

    end # class Numeric
  end # class Attribute
end # module Axiom
