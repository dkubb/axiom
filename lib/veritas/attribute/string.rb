# encoding: utf-8

module Veritas
  class Attribute

    # Represents a String value in a relation tuple
    class String < Object
      include Comparable,
              Function::Predicate::Match::Methods,
              Function::Predicate::NoMatch::Methods

      DEFAULT_MIN_LENGTH = 0
      DEFAULT_MAX_LENGTH = 50

      # The minimum string length for a valid value
      #
      # @example
      #   string.min_length  # => 0
      #
      # @return [::Integer]
      #
      # @api public
      attr_reader :min_length

      # The maximum string length for a valid value
      #
      # @example
      #   string.max_length  # => 50
      #
      # @return [::Integer]
      #
      # @api public
      attr_reader :max_length

      # The String primitive
      #
      # @example
      #   String.primitive  # => ::String
      #
      # @return [Class<::String>]
      #
      # @api public
      def self.primitive
        ::String
      end

      # Initialize a String Attribute
      #
      # @param [#to_sym] name
      #   the attribute name
      # @param [#to_hash] options
      #   the options for the attribute
      # @option options [Boolean] :required (true)
      #   if true, then the value cannot be nil
      # @option options [::Integer] :min_length
      #   The minimum string length for a valid value
      # @option options [::Integer] :mmax_length
      #   The maximum string length for a valid value
      #
      # @return [undefined]
      #
      # @api private
      def initialize(*)
        super
        @min_length = @options.fetch(:min_length, DEFAULT_MIN_LENGTH)
        @max_length = @options.fetch(:max_length, DEFAULT_MAX_LENGTH)
      end

      # Test if the value matches the attribute constraints
      #
      # @example
      #   string.valid_value?(value)  # => true or false
      #
      # @param [Object] value
      #   the value to test
      #
      # @return [Boolean]
      #
      # @api public
      def valid_value?(value)
        valid_or_optional?(value) { super && valid_length?(value) }
      end

      # Test if the attribute can be joined with the other attribute
      #
      # @example
      #   string.joinable?(other)  # => true or false
      #
      # @param [Attribute] other
      #   the other attribute to test
      #
      # @return [Boolean]
      #
      # @api public
      def joinable?(other)
        super                             &&
        min_length.eql?(other.min_length) &&
        max_length.eql?(other.max_length)
      end

    private

      # Test if the value is the correct length
      #
      # @param [String] value
      #
      # @return [Boolean]
      #
      # @api private
      def valid_length?(value)
        value.length.between?(min_length, max_length)
      end

    end # class String
  end # class Attribute
end # module Veritas
