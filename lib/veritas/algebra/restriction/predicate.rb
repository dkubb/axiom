module Veritas
  module Algebra
    class Restriction
      class Predicate
        include AbstractClass
        include BinaryOperation
        include Connective::Methods

        def call(tuple)
          left_value  = extract_value(left,  tuple)
          right_value = extract_value(right, tuple)

          eval(left_value, right_value)
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

        def eval(left, right)
          raise NotImplementedError, "#{self.class.name}#eval must be implemented"
        end

        def extract_value(operand, tuple)
          operand.kind_of?(Attribute) ? tuple[operand] : operand
        end
      end # class Predicate

      class Equality < Predicate
      private

        def eval(left, right)
          left == right
        end
      end # class Equality

      class Inequality < Predicate
      private

        def eval(left, right)
          left != right
        end
      end # class Inequality

      class Inclusion < Predicate
      private

        def eval(left, right)
          right.include?(left)
        end
      end # class Inclusion

      class Match < Predicate
      private

        def eval(left, right)
          right === left
        end
      end # class Match

      class GreaterThanOrEqualTo < Predicate
      private

        def eval(left, right)
          left >= right
        end
      end # class GreaterThanOrEqualTo

      class GreaterThan < Predicate
      private

        def eval(left, right)
          left > right
        end
      end # class GreaterThan

      class LessThanOrEqualTo < Predicate
      private

        def eval(left, right)
          left <= right
        end
      end # class LessThanOrEqualTo

      class LessThan < Predicate
      private

        def eval(left, right)
          left < right
        end
      end # class LessThan
    end # class Restriction
  end # module Algebra
end # module Veritas
