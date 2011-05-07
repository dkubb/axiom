module Veritas
  class Aggregate

    # The sum of a sequence of numbers
    class Sum < Aggregate

      DEFAULT = 0

      # Return the sum for a sequence of numbers
      #
      # @example
      #   sum = Sum.call(sum, value)
      #
      # @param [Numeric] sum
      #
      # @param [Object] value
      #
      # @return [Numeric]
      #
      # @api public
      def self.call(sum, value)
        sum + value
      end

    end # class Sum
  end # class Aggregate
end # module Veritas
