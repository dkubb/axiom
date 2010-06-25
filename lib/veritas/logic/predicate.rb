module Veritas
  module Logic
    class Predicate < Expression
      include AbstractClass, Operation::Binary

      def call(tuple)
        util = self.class

        left_value  = util.extract_value(left,  tuple)
        right_value = util.extract_value(right, tuple)

        util.eval(left_value, right_value)
      end

      def project(attributes)
        return nil if left_attribute?  && !attributes.include?(left)
        return nil if right_attribute? && !attributes.include?(right)
        super
      end

      def rename(aliases)
        left  = self.left
        right = self.right
        util  = self.class

        renamed_left  = util.rename_operand(left,  aliases)
        renamed_right = util.rename_operand(right, aliases)

        if left.equal?(renamed_left) && right.equal?(renamed_right)
          self
        else
          util.new(renamed_left, renamed_right)
        end
      end

      def optimize
        if    foldable?     then fold_constants
        elsif always_false? then Proposition::False.instance
        elsif always_true?  then Proposition::True.instance
        elsif normalizable? then normalize
        else
          super
        end
      end

      def eql?(other)
        instance_of?(other.class) &&
        left.eql?(other.left)     &&
        right.eql?(other.right)
      end

      def hash
        left.hash ^ right.hash
      end

    private

      def fold_constants
        Proposition.new(self.class.eval(left, right))
      end

      def same_attributes?
        left.eql?(right)
      end

      def foldable?
        left_constant? && right_constant?
      end

      def comparable?
        left.comparable?(right)
      end

      def joinable?
        left.joinable?(right)
      end

      def normalizable?
        # normalize if left is a constant, and right is an attribute
        respond_to?(:normalize, true) && left_constant? && right_attribute?
      end

      def left_attribute?
        left.kind_of?(Attribute)
      end

      def right_attribute?
        right.kind_of?(Attribute)
      end

      def left_constant?
        !left_attribute?
      end

      def right_constant?
        !right_attribute?
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

      def self.rename_operand(operand, aliases)
        operand.respond_to?(:rename) ? operand.rename(aliases) : operand
      end

    end # class Predicate
  end # module Logic
end # module Veritas

require 'veritas/logic/predicate/comparable'
require 'veritas/logic/predicate/equality'
require 'veritas/logic/predicate/greater_than'
require 'veritas/logic/predicate/greater_than_or_equal_to'
require 'veritas/logic/predicate/inclusion'
require 'veritas/logic/predicate/inequality'
require 'veritas/logic/predicate/less_than'
require 'veritas/logic/predicate/less_than_or_equal_to'
require 'veritas/logic/predicate/match'
