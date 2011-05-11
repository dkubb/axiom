module Veritas
  class Function

    # Abstract base class for logical predicates
    class Predicate < Function
      include AbstractClass, Binary

      # Rename the contained attributes with the provided aliases
      #
      # @example
      #   renamed = predicate.rename(aliases)
      #
      # @param [Algebra::Rename::Aliases] aliases
      #   the old and new attributes
      #
      # @return [Predicate]
      #
      # @todo find a refactoring that will allow this to be removed in favor of Binary#rename
      #
      # @api public
      def rename(aliases)
        left  = self.left
        right = self.right
        util  = self.class

        renamed_left  = aliases[left]
        renamed_right = aliases[right]

        if left.equal?(renamed_left) && right.equal?(renamed_right)
          self
        else
          util.new(renamed_left, renamed_right)
        end
      end

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
