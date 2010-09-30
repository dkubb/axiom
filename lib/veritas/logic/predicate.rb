module Veritas
  module Logic
    class Predicate < Expression
      include AbstractClass, Operation::Binary

      def call(tuple)
        util = self.class
        util.call(
          util.extract_value(left,  tuple),
          util.extract_value(right, tuple)
        )
      end

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

      def inverse
        self.class.inverse.new(left, right).
          memoize(:inverse, self)
      end

      def self.extract_value(operand, tuple)
        operand.respond_to?(:call) ? operand.call(tuple) : operand
      end

      memoize :inverse

    end # class Predicate
  end # module Logic
end # module Veritas

require 'veritas/logic/predicate/comparable'
require 'veritas/logic/predicate/enumerable'

require 'veritas/logic/predicate/equality'
require 'veritas/logic/predicate/exclusion'
require 'veritas/logic/predicate/greater_than'
require 'veritas/logic/predicate/greater_than_or_equal_to'
require 'veritas/logic/predicate/inclusion'
require 'veritas/logic/predicate/inequality'
require 'veritas/logic/predicate/less_than'
require 'veritas/logic/predicate/less_than_or_equal_to'
require 'veritas/logic/predicate/no_match'
require 'veritas/logic/predicate/match'
