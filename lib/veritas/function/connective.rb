# encoding: utf-8

module Veritas
  class Function

    # Abstract base class for logical connectives
    class Connective < Function
      include AbstractClass

      # Return the type returned from #call
      #
      # @return [Class<Attribute::Boolean>]
      #
      # @api public
      def type
        Attribute::Boolean
      end

    end # class Connective
  end # class Function
end # module Veritas
