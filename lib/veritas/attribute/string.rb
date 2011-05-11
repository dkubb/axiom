module Veritas
  class Attribute

    # Represents a String value in a relation tuple
    class String < Object
      include Orderable,
              Function::Predicate::Match::Methods,
              Function::Predicate::NoMatch::Methods

      DEFAULT_LENGTH = (0..50).freeze

      inheritable_alias(:range => :length)

      # The String length for a valid value
      #
      # @example
      #   string.length  # => 0..50
      #
      # @return [Range<::Integer>]
      #
      # @api public
      attr_reader :length

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
      # @option options [Range<::Integer>] :length (0..50)
      #   The string length for a valid value
      #
      # @return [undefined]
      #
      # @api private
      def initialize(*)
        super
        @length = @options.fetch(:length, DEFAULT_LENGTH).to_inclusive
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
        valid_or_optional?(value) { super && length.cover?(value.length) }
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
        super && length.eql?(other.length)
      end

    end # class String
  end # class Attribute
end # module Veritas
