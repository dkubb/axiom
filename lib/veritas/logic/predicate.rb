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

      def project(attributes)
        left  = self.left
        right = self.right

        return if left.kind_of?(Attribute)  && !attributes.include?(left)
        return if right.kind_of?(Attribute) && !attributes.include?(right)
        super
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

      def complement
        self.class.complement.new(left, right).
          memoize(:complement, self)
      end

      def self.extract_value(operand, tuple)
        operand.respond_to?(:call) ? operand.call(tuple) : operand
      end

      memoize :complement

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
