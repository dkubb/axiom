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

          alias & and

          def or(other)
            Disjunction.new(self, other)
          end

          alias | or

          def not(other)
            self.and(Negation.new(other))
          end

          alias - not

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
          left, right = optimize_left, optimize_right

          if left.eql?(right)
            left
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

          if left.kind_of?(False) || right.kind_of?(True)
            left
          elsif right.kind_of?(False) || left.kind_of?(True)
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

          if left.kind_of?(True) || right.kind_of?(False)
            left
          elsif right.kind_of?(True) || left.kind_of?(False)
            right
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
