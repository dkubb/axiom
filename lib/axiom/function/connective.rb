# encoding: utf-8

module Axiom
  class Function

    # Abstract base class for logical connectives
    class Connective < Function
      include AbstractType

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
end # module Axiom
