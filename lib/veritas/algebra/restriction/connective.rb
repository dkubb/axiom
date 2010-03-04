module Veritas
  module Algebra
    class Restriction
      class Connective
        include AbstractClass
        include Expression
      end # class Connective

      module BinaryConnective
        include Operation::Binary

        def call(tuple)
          self.class.eval(left.call(tuple), right.call(tuple))
        end

        def project(attributes)
          left  = self.left.project(attributes)
          right = self.right.project(attributes)

          if left.nil?
            right
          elsif right.nil?
            left
          else
            super
          end
        end

        def rename(aliases)
          left          = self.left
          right         = self.right
          renamed_left  = left.rename(aliases)
          renamed_right = right.rename(aliases)

          if left.equal?(renamed_left) && right.equal?(renamed_right)
            self
          else
            self.class.new(renamed_left, renamed_right)
          end
        end

        def optimize
          left, right = optimize_left, optimize_right

          if left.eql?(right)
            left
          elsif kind_of?(right.class) && left.eql?(right.left)
            right
          elsif optimized?
            new_optimized_connective
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

        def optimize_left
          @optimize_left ||= left.optimize
        end

        def optimize_right
          @optimize_right ||= right.optimize
        end

        def new_optimized_connective
          self.class.new(optimize_left, optimize_right)
        end

        def optimized?
          !(optimize_left.equal?(left) && optimize_right.equal?(right))
        end

      end

      class Conjunction < Connective
        include BinaryConnective

        def self.eval(left, right)
          left && right
        end

        def optimize
          left, right = optimize_left, optimize_right

          if left.kind_of?(False) || right.kind_of?(False)
            False.instance
          elsif right.kind_of?(True)
            left
          elsif left.kind_of?(True)
            right
          else
            super
          end
        end

        def inspect
          "(#{left.inspect} AND #{right.inspect})"
        end

      end # class Conjunction

      class Disjunction < Connective
        include BinaryConnective

        def self.eval(left, right)
          left || right
        end

        def optimize
          left, right = optimize_left, optimize_right

          if left.kind_of?(True) || right.kind_of?(True)
            True.instance
          elsif right.kind_of?(False)
            left
          elsif left.kind_of?(False)
            right
          elsif collapse_to_inclusion?
            Inclusion.new(left.left, [ left.right, right.right ])
          else
            super
          end
        end

        def inspect
          "(#{left.inspect} OR #{right.inspect})"
        end

      private

        def collapse_to_inclusion?
          left_and_right_equality?         &&
          left_and_right_same_attribute?   &&
          left_and_right_different_values?
        end

        def left_and_right_equality?
          optimize_left.kind_of?(Equality) &&
          optimize_right.kind_of?(Equality)
        end

        def left_and_right_same_attribute?
          optimize_left.left.eql?(optimize_right.left)
        end

        def left_and_right_different_values?
          left_value?       &&
          right_value?      &&
          different_values?
        end

        def left_value?
          !optimize_left.right.kind_of?(Attribute)
        end

        def right_value?
          !optimize_right.right.kind_of?(Attribute)
        end

        def different_values?
          !optimize_left.right.eql?(optimize_right.right)
        end

      end # class Disjunction

      class Negation < Connective
        attr_reader :operand

        def initialize(operand)
          @operand = operand
        end

        def call(tuple)
          self.class.eval(operand.call(tuple))
        end

        def invert
          operand
        end

        def rename(aliases)
          operand         = self.operand
          renamed_operand = operand.rename(aliases)

          if operand.equal?(renamed_operand)
            self
          else
            self.class.new(renamed_operand)
          end
        end

        def optimize
          operand.optimize.invert
        end

        def eql?(other)
          instance_of?(other.class) &&
          operand.eql?(other.operand)
        end

        def hash
          @hash ||= operand.hash
        end

        def inspect
          "NOT(#{operand.inspect})"
        end

        def self.eval(value)
          !value
        end
      end # class Negation
    end # class Restriction
  end # module Algebra
end # module Veritas
