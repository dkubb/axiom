module Veritas
  class Function

    # Abstract base class for logical predicates
    class Predicate < Function
      include AbstractClass, Binary

      # Return the inverse predicate
      #
      # @example
      #   inverse = predicate.inverse
      #
      # @return [Predicate]
      #
      # @todo consider moving this into Binary
      #
      # @api public
      def inverse
        self.class.inverse.new(left, right).
          memoize(:inverse, self)
      end

      memoize :inverse

    end # class Predicate
  end # class Function
end # module Veritas
