# encoding: utf-8

module Veritas
  class Attribute

    # Represents a Time value in a relation tuple
    class Time < Object
      include Comparable

      DEFAULT_RANGE = (::Time.at(0)..::Time.at(2**31-1)).freeze

      # The Time primitive
      #
      # @example
      #   Time.primitive  # => ::Time
      #
      # @return [Class<::Time>]
      #
      # @api public
      def self.primitive
        ::Time
      end

      # The Time range for a valid value
      #
      # @example
      #   Time.range  # => ::Time.utc(*from)..::Time.utc(*to)
      #
      # @return [Range<::Time>]
      #
      # @api public
      def range
        DEFAULT_RANGE
      end

    end # class Time
  end # class Attribute
end # module Veritas
