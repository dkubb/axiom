module Veritas
  class Attribute

    # Represents a DateTime value in a relation tuple
    class DateTime < Object
      include Comparable

      DEFAULT_RANGE = (::DateTime.new..::DateTime::Infinity.new).freeze

      # The DateTime primitive
      #
      # @example
      #   DateTime.primitive  # => ::DateTime
      #
      # @return [Class<::DateTime>]
      #
      # @api public
      def self.primitive
        ::DateTime
      end

      # The DateTime range for a valid value
      #
      # @example
      #   DateTime.range  # => ::DateTime.new(*from)..::DateTime.new(*to)
      #
      # @return [Range<::DateTime>]
      #
      # @api public
      def range
        DEFAULT_RANGE
      end

    end # class DateTime
  end # class Attribute
end # module Veritas
