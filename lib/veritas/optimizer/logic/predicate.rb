module Veritas
  class Optimizer
    module Logic

      # Abstract base class representing Predicate optimizations
      class Predicate < Optimizer

        # The optimized left operand
        #
        # @return [Object]
        #
        # @api private
        attr_reader :left

        # The optimized right operand
        #
        # @return [Object]
        #
        # @api private
        attr_reader :right

        # Initialize an Predicate optimizer
        #
        # @return [undefined]
        #
        # @api private
        def initialize(*)
          super
          @left  = optimize_left
          @right = optimize_right
        end

      private

        # Optimize the left operand
        #
        # @return [Object]
        #
        # @api private
        def optimize_left
          self.class.optimize_operand(operation.left)
        end

        # Optimize the right operand
        #
        # @return [Object]
        #
        # @api private
        def optimize_right
          self.class.optimize_operand(operation.right)
        end

        # Optimize the operand if possible
        #
        # @param [#optimize, Object] operand
        #
        # @return [Object]
        #
        # @api private
        def self.optimize_operand(operand)
          operand.respond_to?(:optimize) ? operand.optimize : operand
        end

        # Optimize when the operands are constants
        class ConstantOperands < self

          # Test if the operands are constants
          #
          # @return [Boolean]
          #
          # @api private
          def optimizable?
            util = Util
            util.constant?(left) && util.constant?(right)
          end

          # A Predicate with constant values is equivalent to a Proposition
          #
          # @return [Proposition]
          #
          # @api private
          def optimize
            Veritas::Logic::Proposition.new(operation.class.call(left, right))
          end

        end # class ConstantOperands

        # Optimize when the operands are always false
        module AlwaysFalse

          # Return false
          #
          # @return [False]
          #
          # @api private
          def optimize
            Veritas::Logic::Proposition::False.instance
          end

        end # module AlwaysFalse

        # Optimize when the operands are always true
        module AlwaysTrue

          # Return true
          #
          # @return [True]
          #
          # @api private
          def optimize
            Veritas::Logic::Proposition::True.instance
          end

        end # module AlwaysTrue

        # Utility methods for Predicate optimization
        module Util

          # Test if the operand is a constant
          #
          # @return [Boolean]
          #
          # @api private
          def self.constant?(operand)
            !operand.respond_to?(:call)
          end

          # Test if the operand is an attribute
          #
          # @return [Boolean]
          #
          # @api private
          def self.attribute?(operand)
            operand.kind_of?(Attribute)
          end

          # Return the minimum value for the operand
          #
          # @return [Object]
          #
          # @api private
          def self.min(operand)
            range_or_operand(operand, :first)
          end

          # Return the maximum value for the operand
          #
          # @return [Object]
          #
          # @api private
          def self.max(operand)
            range_or_operand(operand, :last)
          end

          # Return the minimum/maximum of the operand range, or the operand
          #
          # @param [Object] operand
          #   the object to extract the minimum/maximum value from
          # @param [Symbol] method
          #   the method to execute on the operand range, if any
          #
          # @return [Object]
          #
          # @api private
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
