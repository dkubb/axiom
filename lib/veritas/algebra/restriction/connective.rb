module Veritas
  module Algebra
    class Restriction
      class Connective
        include AbstractClass
        include Optimizable

        module Methods
          def and(other)
            Conjunction.new(self, other)
          end

          def or(other)
            Disjunction.new(self, other)
          end

          def not(other)
            self.and(Negation.new(other))
          end
        end # module Methods

        include Methods

        def invert
          Negation.new(self)
        end

        def inspect
          raise NotImplementedError, "#{self.class.name}#inspect must be implemented"
        end

      end # class Connective

      module BinaryConnective
        include Operation::Binary

        def call(tuple)
          self.class.eval(left.call(tuple), right.call(tuple))
        end

        def optimize
          if left.eql?(right)
            left
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
      end

      class Conjunction < Connective
        include BinaryConnective

        def self.eval(left, right)
          left && right
        end

        def optimize
          left  = self.left.optimize
          right = self.right.optimize

          if left.kind_of?(False) || right.kind_of?(False)
            False.new
          elsif left.kind_of?(True)
            right
          elsif right.kind_of?(True)
            left
          elsif !left.eql?(self.left) || !right.eql?(self.right)
            self.class.new(left, right)
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
          left  = self.left.optimize
          right = self.right.optimize

          if left.kind_of?(True) || right.kind_of?(True)
            True.new
          elsif left.kind_of?(False)
            right
          elsif right.kind_of?(False)
            left
          elsif !left.eql?(self.left) || !right.eql?(self.right)
            self.class.new(left, right)
          else
            super
          end
        end

        def inspect
          "(#{left.inspect} OR #{right.inspect})"
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
