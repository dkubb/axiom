module Veritas
  module Function

    # Abstract base class for logical connectives
    class Connective < Expression
      include AbstractClass

      # Return the inverse connective
      #
      # @example
      #   negation = connective.inverse
      #
      # @return [Negation]
      #
      # @api public
      def inverse
        Negation.new(self)
      end

      memoize :inverse

    end # class Connective
  end # module Function
end # module Veritas
