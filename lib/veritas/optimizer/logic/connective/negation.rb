module Veritas
  class Optimizer
    module Logic
      module Connective
        class Negation < Optimizer
          attr_reader :operand

          def initialize(*)
            super
            @operand = optimize_operand
          end

        private

          def optimize_operand
            # TODO: move Predicate.optimize_operand to a better location
            Predicate.optimize_operand(operation.operand)
          end

          class InvertibleOperand < self
            def optimizable?
              operand.respond_to?(:inverse)
            end

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
