module Veritas
  class Aggregate

    # The mean of a sequence of numbers
    class Mean < Aggregate

      # Return the count and mean for a sequence of numbers
      #
      # @example
      #   count, mean = Mean.call([ count, mean ], value)
      #
      # @param [Array(Numeric, Numeric)] accumulator
      #
      # @param [Numeric] value
      #
      # @return [Array(Numeric, Numeric)]
      #
      # @api public
      def self.call(accumulator, value)
        count, mean = accumulator
        count       = count.succ
        [ count, mean.nil? ? value : mean + ((value - mean) / count.to_f) ]
      end

    end # class Mean
  end # class Aggregate
end # module Veritas
