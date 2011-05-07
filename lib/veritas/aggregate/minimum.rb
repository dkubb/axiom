module Veritas
  class Aggregate

    # The maximum value in a sequence of numbers
    class Minimum < Aggregate

      # Return the minimum value for a sequence of numbers
      #
      # @example
      #   minimum = Minimum.call(minimum, value)
      #
      # @param [Numeric] minimum
      #
      # @param [Numeric] value
      #
      # @return [Numeric]
      #
      # @api public
      def self.call(minimum, value)
        value < minimum ? value : minimum
      end

    end # class Minimum
  end # class Aggregate
end # module Veritas
