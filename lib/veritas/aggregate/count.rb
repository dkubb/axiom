module Veritas
  class Aggregate

    # The count of a series of values
    class Count < Aggregate

      # Return the count for a series of values
      #
      # @example
      #   count = Count.call(count, value)
      #
      # @param [Integer] count
      #
      # @param [Object] _value
      #
      # @return [Integer]
      #
      # @api public
      def self.call(count, _value)
        count.succ
      end

    end # class Count
  end # class Aggregate
end # module Veritas
