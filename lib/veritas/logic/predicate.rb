module Veritas
  module Logic
    class Predicate
      include AbstractClass, Expression, Operation::Binary

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
        if    always_false? || left.nil? && right.nil? then Proposition::False.instance
        elsif always_true?                             then Proposition::True.instance
        elsif swappable?                               then swap
        elsif !left_attribute? && !right_attribute?    then evaluate_literal_values
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
        @hash ||= left.hash ^ right.hash
      end

    private

      def evaluate_literal_values
        Proposition.new(self.class.eval(left, right))
      end

      def equivalent?
        left.eql?(right)
      end

      def comparable?
        left.comparable?(right)
      end

      def joinable?
        left.joinable?(right)
      end

      def swappable?
        # if possible swap the left and right if left is a value, and right is an attribute
        respond_to?(:swap, true) && !left_attribute? && right_attribute?
      end

      def left_attribute?
        left.kind_of?(Attribute)
      end

      def right_attribute?
        right.kind_of?(Attribute)
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

      module ComparisonPredicate
      private

        def swap
          self.class.new(right, left)
        end

        def always_equivalent?
          left_attribute? && right_attribute? && equivalent?
        end

        def never_equivalent?
          left  = self.left
          right = self.right

          left_attribute  = left_attribute?
          right_attribute = right_attribute?

          if    left_attribute && right_attribute then !joinable?
          elsif left_attribute                    then !left.valid_value?(right)
          elsif right_attribute                   then !right.valid_value?(left)
          else
            false
          end
        end

      end # module ComparisonPredicate
    end # class Predicate
  end # module Logic
end # module Veritas

require 'veritas/logic/predicate/equality'
require 'veritas/logic/predicate/greater_than'
require 'veritas/logic/predicate/greater_than_or_equal_to'
require 'veritas/logic/predicate/inclusion'
require 'veritas/logic/predicate/inequality'
require 'veritas/logic/predicate/less_than'
require 'veritas/logic/predicate/less_than_or_equal_to'
require 'veritas/logic/predicate/match'
