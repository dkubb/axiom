module Veritas
  class Aggregate

    # The maximum value in a sequence of numbers
    class Maximum < Aggregate

      # Return the maximum value for a sequence of numbers
      #
      # @example
      #   maximum = Maximum.call(maximum, value)
      #
      # @param [Numeric] maximum
      #
      # @param [Numeric] value
      #
      # @return [Numeric]
      #
      # @api public
      def self.call(maximum, value)
        value > maximum ? value : maximum
      end

    end # class Maximum
  end # class Aggregate
end # module Veritas
