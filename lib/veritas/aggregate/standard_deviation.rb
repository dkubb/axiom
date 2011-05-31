# encoding: utf-8

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
      #   returned for a non-empty set
      # @return [nil]
      #   returned for an empty set
      #
      # @api public
      def self.finalize(*)
        variance = super
        Math.sqrt(variance) if variance
      end

      # Return the type returned from #call
      #
      # @return [Class<Attribute::Float>]
      #
      # @api public
      def type
        Attribute::Float
      end

      module Methods
        extend Aliasable

        inheritable_alias(:stddev => :standard_deviation)

        # Return a standard deviation aggregate function
        #
        # @example
        #   standard_deviation = attribute.standard_deviation
        #
        # @param [Attribute]
        #
        # @return [StandardDeviation]
        #
        # @api public
        def standard_deviation
          StandardDeviation.new(self)
        end

      end # module Methods
    end # class StandardDeviation
  end # class Aggregate
end # module Veritas
