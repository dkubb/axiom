module Veritas
  module Logic
    class Predicate < Expression
      include AbstractClass, Operation::Binary

      def call(tuple)
        util = self.class
        util.eval(
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

        renamed_left  = aliases.fetch(left,  left)
        renamed_right = aliases.fetch(right, right)

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

      def optimize
        if    constant?     then new_proposition
        elsif always_false? then Proposition::False.instance
        elsif always_true?  then Proposition::True.instance
        elsif normalizable? then normalize
        else
          super
        end
      end

    private

      def new_proposition
        Proposition.new(self.class.eval(left, right))
      end

      def same_attributes?
        left.equal?(right)
      end

      def constant?
        left_constant? && right_constant?
      end

      def comparable?
        left.comparable?(right)
      end

      def joinable?
        left.joinable?(right)
      end

      def normalizable?
        false
      end

      def right_attribute?
        right.kind_of?(Attribute)
      end

      def left_constant?
        !left.respond_to?(:call)
      end

      def right_constant?
        !right.respond_to?(:call)
      end

      def left_valid_primitive?
        right.valid_primitive?(left)
      end

      def right_valid_primitive?
        left.valid_primitive?(right)
      end

      def always_false?
        false
      end

      def always_true?
        false
      end

      def left_min
        self.class.range_or_value(left, :first)
      end

      def left_max
        self.class.range_or_value(left, :last)
      end

      def right_min
        self.class.range_or_value(right, :first)
      end

      def right_max
        self.class.range_or_value(right, :last)
      end

      def self.range_or_value(value, method)
        value.respond_to?(:range) ? value.range.send(method) : value
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
