# encoding: utf-8

module Axiom
  class Function
    class Numeric

      # A mixin for numeric Unary functions
      module Unary
        include Function::Unary

        # Return the type returned from #call
        #
        # @example
        #   unary.type  # => Attribute::Numeric
        #
        # @return [Class<Attribute::Numeric>]
        #
        # @api public
        def type
          Attribute.infer_type(operand)
        end

      end # module Unary
    end # class Numeric
  end # class Function
end # module Axiom
