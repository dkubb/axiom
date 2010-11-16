module Veritas
  class Optimizer
    module Logic
      module Connective

        # Abstract base class representing Negation optimizations
        class Negation < Optimizer

          # The optimized operand
          #
          # @return [Expression]
          #
          # @api private
          attr_reader :operand

          # Initialize a Unary optimizer
          #
          # @return [undefined]
          #
          # @api private
          def initialize(*)
            super
            @operand = optimize_operand
          end

        private

          # Optimize the operand
          #
          # @return [Expression]
          #
          # @api private
          def optimize_operand
            # TODO: move Predicate.optimize_operand to a better location
            Predicate.optimize_operand(operation.operand)
          end

          # Optimzie when the operand can be inverted
          class InvertibleOperand < self

            # Test if the operand can be inverted
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              operand.respond_to?(:inverse)
            end

            # A Negation of an Expression is equivalent to the inverted Expression
            #
            # @return [Expression]
            #
            # @api private
            def optimize
              operand.inverse
            end

          end # class InvertibleOperand

          Veritas::Logic::Connective::Negation.optimizer = chain(
            InvertibleOperand
          )

        end # class Negation
      end # module Connective
    end # module Logic
  end # class Optimizer
end # module Veritas
