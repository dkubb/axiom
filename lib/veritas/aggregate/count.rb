# encoding: utf-8

module Veritas
  class Aggregate

    # The count of a series of values
    class Count < Aggregate

      DEFAULT = 0

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

      module Methods

        # Return a count aggregate function
        #
        # @example
        #   count = attribute.count
        #
        # @param [Attribute]
        #
        # @return [Count]
        #
        # @api public
        def count
          Count.new(self)
        end

      end # module Methods
    end # class Count
  end # class Aggregate
end # module Veritas
