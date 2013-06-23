# encoding: utf-8

module Axiom
  class Attribute

    # Represents a Numeric value in a relation tuple
    class Numeric < Object
      include Comparable,
              Aggregate::Sum::Methods
      include Equalizer.new(:name, :required?, :size)

      DEFAULT_SIZE = (-::Float::INFINITY..::Float::INFINITY).freeze

      inheritable_alias(range: :size)

      # The Numeric range for a valid value
      #
      # @example
      #   numeric.size  # => 0..10
      #
      # @return [Range<::Numeric>]
      #
      # @api public
      attr_reader :size

      # The Numeric primitive
      #
      # @example
      #   Numeric.primitive  # => ::Numeric
      #
      # @return [Class<::Numeric>]
      #
      # @api public
      def self.primitive
        ::Numeric
      end

      # Initialize a Numeric Attribute
      #
      # @param [#to_sym] _name
      #   the attribute name
      # @param [#to_hash] _options
      #   the options for the attribute
      # @option options [Boolean] :required (true)
      #   if true, then the value cannot be nil
      # @option options [Range<::Numeric>] :size (0..2**31-1)
      #   The numeric range for a valid value
      #
      # @return [undefined]
      #
      # @api private
      def initialize(_name, _options = EMPTY_HASH)
        super
        @size = @options.fetch(:size, self.class::DEFAULT_SIZE).to_inclusive
      end

      # Test if the value matches the attribute constraints
      #
      # @example
      #   numeric.valid_value?(value)  # => true or false
      #
      # @param [Object] value
      #   the value to test
      #
      # @return [Boolean]
      #
      # @api public
      def valid_value?(value)
        valid_or_optional?(value) { super && size.cover?(value) }
      end

    end # class Numeric
  end # class Attribute
end # module Axiom
