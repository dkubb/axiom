# encoding: utf-8

module Veritas
  class Aggregate

    # The maximum value in a sequence of numbers
    class Minimum < Aggregate

      DEFAULT = Float::INFINITY

      # Return the minimum value for a sequence of numbers
      #
      # @example
      #   minimum = Minimum.call(minimum, value)
      #
      # @param [Numeric] minimum
      #
      # @param [Numeric] value
      #
      # @return [Numeric]
      #
      # @api public
      def self.call(minimum, value)
        return minimum if value.nil?
        value < minimum ? value : minimum
      end

      module Methods
        extend Aliasable

        inheritable_alias(:min => :minimum)

        # Return a minimum aggregate function
        #
        # @example
        #   minimum = attribute.minimum
        #
        # @param [Attribute]
        #
        # @return [Minimum]
        #
        # @api public
        def minimum
          Minimum.new(self)
        end

      end # module Methods
    end # class Minimum
  end # class Aggregate
end # module Veritas
