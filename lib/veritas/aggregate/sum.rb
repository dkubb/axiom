# encoding: utf-8

module Veritas
  class Aggregate

    # The sum of a sequence of numbers
    class Sum < Aggregate

      DEFAULT = 0

      # Return the sum for a sequence of numbers
      #
      # @example
      #   sum = Sum.call(sum, value)
      #
      # @param [Numeric] sum
      #
      # @param [Object] value
      #
      # @return [Numeric]
      #
      # @api public
      def self.call(sum, value)
        return sum if value.nil?
        sum + value
      end

      # Return the default sum
      #
      # @example when the operand is a float
      #   default = sum.default  # => 0.0
      #
      # @example when the operand is a decimal
      #   default = sum.default  # => BigDecimal('0.0')
      #
      # @example when the operand is an integer
      #   default = sum.default  # => 0
      #
      # @return [Numeric]
      #
      # @todo refactor once functions know their return types
      #
      # @api public
      def default
        type = self.type
        if    type.equal?(Attribute::Float)   then super.to_f
        elsif type.equal?(Attribute::Decimal) then BigDecimal(super.to_s)
        else
          super
        end
      end

      # Return the type returned from #call
      #
      # @return [Class<Attribute::Numeric>]
      #
      # @api public
      def type
        Function::Numeric.infer_type(operand)
      end

      module Methods

        # Return a sum aggregate function
        #
        # @example
        #   sum = attribute.sum
        #
        # @param [Attribute]
        #
        # @return [Sum]
        #
        # @api public
        def sum
          Sum.new(self)
        end

      end # module Methods
    end # class Sum
  end # class Aggregate
end # module Veritas
