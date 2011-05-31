# encoding: utf-8

module Veritas
  class Function

    # Abstract class for Numeric functions
    class Numeric < Function
      include AbstractClass

      # Infer the Attribute type from the operand
      #
      # @param [Object] operand
      #
      # @return [Class<Attribute>]
      #
      # @raise [ArgumentError]
      #   thrown if the operand is of an unhandled type
      #
      # @api private
      def self.infer_type(operand)
        case operand
          when Attribute, Function then operand.type
          when BigDecimal          then Attribute::Decimal
          when Float               then Attribute::Float
          when Integer             then Attribute::Integer
          else
            raise ArgumentError, "unhandled operand type: #{operand.class}"
        end
      end

    end # class Numeric
  end # class Function
end # module Veritas
