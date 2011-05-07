module Veritas
  class Aggregate

    # The variance of a sequence of numbers
    class Variance < Aggregate

      DEFAULT = [ 0, nil, 0 ].freeze

      # Return the count, mean, and sum of squares for a sequence of numbers
      #
      # @example
      #   count, mean, sum_of_squares = Variance.call(accumulator, value)
      #
      # @param [Array(Numeric, Numeric, Numeric)] accumulator
      #
      # @param [Numeric] value
      #
      # @return [Array(Numeric, Numeric, Numeric)]
      #
      # @api public
      def self.call(accumulator, value)
        mean, sum_of_squares  = accumulator.last(2)
        delta                 = mean.nil? ? value : value - mean
        count, new_mean       = Mean.call(accumulator, value)
        sum_of_squares       += delta * (value - new_mean)
        [ count, new_mean, sum_of_squares ]
      end

      # Calculate the variance from the accumulator
      #
      # @example
      #   variance = Variance.finalize(accumulator)
      #
      # @param [Array(Numeric, Numeric, Numeric)] accumulator
      #
      # @return [Float]
      #
      # @api public
      def self.finalize(accumulator)
        count, new_mean, sum_of_squares = accumulator
        sum_of_squares / count.to_f
      end

    end # class Variance
  end # class Aggregate
end # module Veritas
