module Veritas
  class Aggregate

    # The variance of a sequence of numbers
    class Variance < Aggregate

      DEFAULT = [ 0, nil, 0 ].freeze

      # Return the count, mean, and sum of squares for a sequence of numbers
      #
      # @example
      #   count, mean, sum_of_squares = Variance.call([ count, mean, sum_of_squares ], value)
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

    end # class Variance
  end # class Aggregate
end # module Veritas
