module Veritas
  class Aggregate

    # The mean of a sequence of numbers
    class Mean < Aggregate

      DEFAULT = [ 0, nil ].freeze

      # Return the count and mean for a sequence of numbers
      #
      # @example
      #   count, mean = Mean.call([ count, mean ], value)
      #
      # @param [Array(Integer, Numeric)] accumulator
      #
      # @param [Numeric] value
      #
      # @return [Array(Integer, Numeric)]
      #
      # @api public
      def self.call(accumulator, value)
        count, mean = accumulator
        count       = count.succ
        [ count, mean.nil? ? value : mean + ((value - mean) / count.to_f) ]
      end

      # Extract the mean from the accumulator
      #
      # @example
      #   mean = Mean.finalize(accumulator)
      #
      # @param [Array(Integer, Numeric)] accumulator
      #
      # @return [Float]
      #
      # @api public
      def self.finalize(accumulator)
        accumulator.last
      end

    end # class Mean
  end # class Aggregate
end # module Veritas
