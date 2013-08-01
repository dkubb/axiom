# encoding: utf-8

module Axiom
  class Function
    class Numeric

      # A mixin for numeric Binary functions
      module Binary
        include Function::Binary

        # Return the type returned from #call
        #
        # @example
        #   type = binary.type
        #
        # @return [Class<Attribute::Numeric>]
        #
        # @api public
        def type
          util       = Attribute
          left_type  = util.infer_type(left)
          right_type = util.infer_type(right)
          left_type.equal?(right_type) ? left_type : Attribute::Numeric
        end

      end # module Binary
    end # class Numeric
  end # class Function
end # module Axiom
