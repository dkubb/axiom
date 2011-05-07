module Veritas
  class Aggregate

    # The standard deviation of a sequence of numbers
    class StandardDeviation < Variance

      # Calculate the standard deviation from the accumulator
      #
      # @example
      #   standard_deviation = StandardDeviation.finalize(accumulator)
      #
      # @param [Array(Numeric, Integer, Numeric)] accumulator
      #
      # @return [Float]
      #
      # @api public
      def self.finalize(*)
        Math.sqrt(super)
      end

    end # class StandardDeviation
  end # class Aggregate
end # module Veritas
