module Veritas
  module Algebra
    class Restriction
      class Predicate
        include AbstractClass
        include BinaryOperation
        include Connective::Methods

        def call(tuple)
          util = self.class

          left_value  = util.extract_value(left,  tuple)
          right_value = util.extract_value(right, tuple)

          util.eval(left_value, right_value)
        end

        def eql?(other)
          instance_of?(other.class) &&
          left.eql?(other.left)     &&
          right.eql?(other.right)
        end

        alias == eql?

        def hash
          left.hash ^ right.hash
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
      end # class Equality

      class Inequality < Predicate
        def self.eval(left, right)
          left != right
        end
      end # class Inequality

      class Inclusion < Predicate
        def self.eval(left, right)
          right.include?(left)
        end
      end # class Inclusion

      class Match < Predicate
        def self.eval(left, right)
          right === left
        end
      end # class Match

      class GreaterThanOrEqualTo < Predicate
        def self.eval(left, right)
          left >= right
        end
      end # class GreaterThanOrEqualTo

      class GreaterThan < Predicate
        def self.eval(left, right)
          left > right
        end
      end # class GreaterThan

      class LessThanOrEqualTo < Predicate
        def self.eval(left, right)
          left <= right
        end
      end # class LessThanOrEqualTo

      class LessThan < Predicate
        def self.eval(left, right)
          left < right
        end
      end # class LessThan
    end # class Restriction
  end # module Algebra
end # module Veritas
