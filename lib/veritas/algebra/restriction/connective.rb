module Veritas
  module Algebra
    class Restriction
      class Connective
        include AbstractClass

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
      end # class Connective

      module BinaryConnective
        include Algebra::BinaryOperation

        def call(tuple)
          eval(left.call(tuple), right.call(tuple))
        end

        def eql?(other)
          instance_of?(other.class) &&
          left.eql?(other.left)     &&
          right.eql?(other.right)
        end

        def hash
          left.hash ^ right.hash
        end
      end

      class Conjunction < Connective
        include BinaryConnective

      private

        def eval(left, right)
          left && right
        end
      end # class Conjunction

      class Disjunction < Connective
        include BinaryConnective

      private

        def eval(left, right)
          left || right
        end
      end # class Disjunction

      class Negation < Connective
        attr_reader :operand

        def initialize(operand)
          @operand = operand
        end

        def call(tuple)
          eval(operand.call(tuple))
        end

        def eql?(other)
          instance_of?(other.class) &&
          operand.eql?(other.operand)
        end

        def hash
          operand.hash
        end

      private

        def eval(value)
          !value
        end
      end # class Negation
    end # class Restriction
  end # module Algebra
end # module Veritas
