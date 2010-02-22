module Veritas
  module Algebra
    class Restriction
      class Predicate
        include AbstractClass
        include Expression
        include Operation::Binary

        def call(tuple)
          util = self.class

          left_value  = util.extract_value(left,  tuple)
          right_value = util.extract_value(right, tuple)

          util.eval(left_value, right_value)
        end

        def optimize
          left  = self.left
          right = self.right

          return false_proposition if always_false? || left.nil? && right.nil?
          return true_proposition  if always_true?

          return super if left_attribute? || right_attribute?

          Proposition.new(self.class.eval(left, right))
        end

        def eql?(other)
          instance_of?(other.class) &&
          left.eql?(other.left)     &&
          right.eql?(other.right)
        end

        def hash
          @hash ||= left.hash ^ right.hash
        end

        def self.extract_value(operand, tuple)
          operand.kind_of?(Attribute) ? tuple[operand] : operand
        end

      private

        def equivalent?
          left.eql?(right)
        end

        def comparable?
          left.comparable?(right)
        end

        def joinable?
          left.joinable?(right)
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

        def true_proposition
          True.instance
        end

        def false_proposition
          False.instance
        end

        def range_or_value(attribute, range_method)
          value = send(attribute)
          value.respond_to?(:range)  ? value.range.send(range_method) : value
        end

        def left_min
          range_or_value(:left, :first)
        end

        def left_max
          range_or_value(:left, :last)
        end

        def right_min
          range_or_value(:right, :first)
        end

        def right_max
          range_or_value(:right, :last)
        end

      end # class Predicate

      module ComparisonPredicate
      private

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
      end

      class Equality < Predicate
        include ComparisonPredicate

        def self.eval(left, right)
          left == right
        end

        def invert
          Inequality.new(left, right)
        end

        def inspect
          "#{left.inspect} == #{right.inspect}"
        end

      private

        def always_true?
          always_equivalent?
        end

        def always_false?
          never_equivalent?
        end

      end # class Equality

      class Inequality < Predicate
        include ComparisonPredicate

        def self.eval(left, right)
          left != right
        end

        def invert
          Equality.new(left, right)
        end

        def inspect
          "#{left.inspect} != #{right.inspect}"
        end

      private

        def always_true?
          never_equivalent?
        end

        def always_false?
          always_equivalent?
        end

      end # class Inequality

      class Inclusion < Predicate
        def self.eval(left, right)
          right.include?(left)
        end

        def optimize
          left = self.left

          return false_proposition if right.kind_of?(Range) && !left.kind_of?(Attribute::Comparable)

          right = optimize_right

          if right.nil? || right.respond_to?(:empty?) && right.empty?
            return false_proposition
          elsif right != self.right
            return self.class.new(left, right)
          end

          super
        end

        def inspect
          "#{left.inspect} IN(#{right.inspect})"
        end

      private

        def optimize_right
          right = self.right

          if right.respond_to?(:to_inclusive)
            right = right.to_inclusive
            return [] if empty_right?           ||
                         left_max < right.first ||
                         left_min > right.last
          elsif right.respond_to?(:select)
            return right.select { |value| left.valid_value?(value) }
          end

          right
        end

        def empty_right?
          right.each { return false }
          true
        end

      end # class Inclusion

      class Match < Predicate
        def self.eval(left, right)
          right === left
        end

        def inspect
          "#{left.inspect} =~ #{right.inspect}"
        end

      end # class Match

      class GreaterThanOrEqualTo < Predicate
        def self.eval(left, right)
          left >= right
        end

        def invert
          LessThan.new(left, right)
        end

        def inspect
          "#{left.inspect} >= #{right.inspect}"
        end

      private

        def always_true?
          if left_attribute? && right_attribute? && equivalent?
            true
          else
            left_min > right_max
          end
        end

        def always_false?
          left  = self.left
          right = self.right

          left_attribute  = left_attribute?
          right_attribute = right_attribute?

          if left_attribute && right_attribute
            return true unless comparable?

          elsif left_attribute
            return true unless left.valid_primitive?(right)

          elsif right_attribute
            return true unless right.valid_primitive?(left)

          end

          left_max < right_min
        end

      end # class GreaterThanOrEqualTo

      class GreaterThan < Predicate
        def self.eval(left, right)
          left > right
        end

        def invert
          LessThanOrEqualTo.new(left, right)
        end

        def inspect
          "#{left.inspect} > #{right.inspect}"
        end

      private

        def always_true?
          left_min > right_max
        end

        def always_false?
          left  = self.left
          right = self.right

          left_attribute  = left_attribute?
          right_attribute = right_attribute?

          if left_attribute && right_attribute
            return true if     equivalent?
            return true unless comparable?

          elsif left_attribute
            return true unless left.valid_primitive?(right)

          elsif right_attribute
            return true unless right.valid_primitive?(left)

          end

          left_max <= right_min
        end

      end # class GreaterThan

      class LessThanOrEqualTo < Predicate
        def self.eval(left, right)
          left <= right
        end

        def invert
          GreaterThan.new(left, right)
        end

        def inspect
          "#{left.inspect} <= #{right.inspect}"
        end

      private

        def always_true?
          if left_attribute? && right_attribute? && equivalent?
            true
          else
            left_max < right_min
          end
        end

        def always_false?
          left  = self.left
          right = self.right

          left_attribute  = left_attribute?
          right_attribute = right_attribute?

          if left_attribute && right_attribute
            return true unless comparable?

          elsif left_attribute
            return true unless left.valid_primitive?(right)

          elsif right_attribute
            return true unless right.valid_primitive?(left)

          end

          left_min > right_max
        end

      end # class LessThanOrEqualTo

      class LessThan < Predicate
        def self.eval(left, right)
          left < right
        end

        def invert
          GreaterThanOrEqualTo.new(left, right)
        end

        def inspect
          "#{left.inspect} < #{right.inspect}"
        end

      private

        def always_true?
          left_max < right_min
        end

        def always_false?
          left  = self.left
          right = self.right

          left_attribute  = left_attribute?
          right_attribute = right_attribute?

          if left_attribute && right_attribute
            return true if     equivalent?
            return true unless comparable?

          elsif left_attribute
            return true unless left.valid_primitive?(right)

          elsif right_attribute
            return true unless right.valid_primitive?(left)

          end

          left_min >= right_max
        end

      end # class LessThan
    end # class Restriction
  end # module Algebra
end # module Veritas
