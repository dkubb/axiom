module Veritas
  class Optimizer
    module Logic
      module Connective
        class Complement < Optimizer
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

          class ComplementableOperand < self
            def optimizable?
              operand.respond_to?(:inverse)
            end

            def optimize
              operand.inverse
            end

          end # class ComplementableOperand

          Veritas::Logic::Connective::Complement.optimizer = chain(
            ComplementableOperand
          )

        end # class Complement
      end # module Connective
    end # module Logic
  end # class Optimizer
end # module Veritas
