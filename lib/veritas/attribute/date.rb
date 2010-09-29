module Veritas
  class Attribute

    # Represents a Date value in a relation tuple
    class Date < Object
      include Comparable

      DEFAULT_RANGE = (::Date.new..::Date::Infinity.new).freeze

      # The Date primitive
      #
      # @example
      #   Date.primitive  # => ::Date
      #
      # @return [::Date]
      #
      # @api public
      def self.primitive
        ::Date
      end

      # The Date range for a valid value
      #
      # @example
      #   Date.range  # => ::Date.new(*from)..::Date.new(*to)
      #
      # @return [Range<::Date>]
      #
      # @api public
      def range
        DEFAULT_RANGE
      end

    end # class Date
  end # class Attribute
end # module Veritas
