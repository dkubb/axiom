module Veritas
  class Optimizer
    module Logic
      class Predicate < Optimizer
        attr_reader :left, :right

        def initialize(*)
          super
          @left  = optimize_left
          @right = optimize_right
        end

      private

        def optimize_left
          self.class.optimize_operand(operation.left)
        end

        def optimize_right
          self.class.optimize_operand(operation.right)
        end

        def self.optimize_operand(operand)
          operand.respond_to?(:optimize) ? operand.optimize : operand
        end

        class ConstantOperands < self
          def optimizable?
            util = Util
            util.constant?(left) && util.constant?(right)
          end

          def optimize
            Veritas::Logic::Proposition.new(operation.class.call(left, right))
          end

        end # class ConstantOperands

        module AlwaysFalse
          def optimize
            Veritas::Logic::Proposition::False.instance
          end

        end # module AlwaysFalse

        module AlwaysTrue
          def optimize
            Veritas::Logic::Proposition::True.instance
          end

        end # module AlwaysTrue

        module Util
          def self.constant?(operand)
            !operand.respond_to?(:call)
          end

          def self.attribute?(operand)
            operand.kind_of?(Attribute)
          end

          def self.min(operand)
            range_or_operand(operand, :first)
          end

          def self.max(operand)
            range_or_operand(operand, :last)
          end

          def self.range_or_operand(operand, method)
            operand.respond_to?(:range) ? operand.range.send(method) : operand
          end

          private_class_method :range_or_operand
        end # module Util
      end # class Predicate
    end # module Logic
  end # class Optimizer
end # module Veritas

require 'veritas/optimizer/logic/predicate/comparable'
require 'veritas/optimizer/logic/predicate/enumerable'

require 'veritas/optimizer/logic/predicate/equality'
require 'veritas/optimizer/logic/predicate/exclusion'
require 'veritas/optimizer/logic/predicate/greater_than'
require 'veritas/optimizer/logic/predicate/greater_than_or_equal_to'
require 'veritas/optimizer/logic/predicate/inequality'
require 'veritas/optimizer/logic/predicate/inclusion'
require 'veritas/optimizer/logic/predicate/less_than'
require 'veritas/optimizer/logic/predicate/less_than_or_equal_to'
