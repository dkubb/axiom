module Veritas
  module Algebra
    class Restriction
      class Predicate
        include AbstractClass
        include Connective::Methods
        include Operation::Binary
        include Optimizable

        def call(tuple)
          util = self.class

          left_value  = util.extract_value(left,  tuple)
          right_value = util.extract_value(right, tuple)

          util.eval(left_value, right_value)
        end

        def invert
          Negation.new(self)
        end

        def optimize
          right, left = self.right, self.left

          if left.kind_of?(Attribute) || right.kind_of?(Attribute)
            super
          else
            Proposition.new(self.class.eval(left, right))
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

        def inspect
          raise NotImplementedError, "#{self.class.name}#inspect must be implemented"
        end

        def self.eval(left, right)
          raise NotImplementedError, "#{name}.eval must be implemented"
        end

        def self.extract_value(operand, tuple)
          operand.kind_of?(Attribute) ? tuple[operand] : operand
        end
      end # class Predicate

      class Equality < Predicate
        def self.eval(left, right)
          left == right
        end

        def invert
          Inequality.new(left, right)
        end

        def optimize
          right, left = self.right, self.left

          if left == right && left.kind_of?(Attribute) && right.kind_of?(Attribute)
            True.instance
          else
            super
          end
        end

        def inspect
          "#{left.inspect} == #{right.inspect}"
        end

      end # class Equality

      class Inequality < Predicate
        def self.eval(left, right)
          left != right
        end

        def invert
          Equality.new(left, right)
        end

        def optimize
          right, left = self.right, self.left

          if left == right && left.kind_of?(Attribute) && right.kind_of?(Attribute)
            False.instance
          else
            super
          end
        end

        def inspect
          "#{left.inspect} != #{right.inspect}"
        end

      end # class Inequality

      class Inclusion < Predicate
        def self.eval(left, right)
          right.include?(left)
        end

        def inspect
          "#{left.inspect} IN(#{right.inspect})"
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

        def optimize
          right, left = self.right, self.left

          if left == right && left.kind_of?(Attribute) && right.kind_of?(Attribute)
            True.instance
          else
            super
          end
        end

        def inspect
          "#{left.inspect} >= #{right.inspect}"
        end

      end # class GreaterThanOrEqualTo

      class GreaterThan < Predicate
        def self.eval(left, right)
          left > right
        end

        def invert
          LessThanOrEqualTo.new(left, right)
        end

        def optimize
          right, left = self.right, self.left

          if left == right && left.kind_of?(Attribute) && right.kind_of?(Attribute)
            False.instance
          else
            super
          end
        end

        def inspect
          "#{left.inspect} > #{right.inspect}"
        end

      end # class GreaterThan

      class LessThanOrEqualTo < Predicate
        def self.eval(left, right)
          left <= right
        end

        def invert
          GreaterThan.new(left, right)
        end

        def optimize
          right, left = self.right, self.left

          if left == right && left.kind_of?(Attribute) && right.kind_of?(Attribute)
            True.instance
          else
            super
          end
        end

        def inspect
          "#{left.inspect} <= #{right.inspect}"
        end

      end # class LessThanOrEqualTo

      class LessThan < Predicate
        def self.eval(left, right)
          left < right
        end

        def invert
          GreaterThanOrEqualTo.new(left, right)
        end

        def optimize
          right, left = self.right, self.left

          if left == right && left.kind_of?(Attribute) && right.kind_of?(Attribute)
            False.instance
          else
            super
          end
        end

        def inspect
          "#{left.inspect} < #{right.inspect}"
        end

      end # class LessThan
    end # class Restriction
  end # module Algebra
end # module Veritas
