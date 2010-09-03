module Veritas
  class Optimizer
    module Logic
      class Predicate
        class Exclusion < self
          include Enumerable

          class EmptyRightOperand < self
            include Enumerable::EmptyRightOperand

            def optimize
              Veritas::Logic::Proposition::True.instance
            end

          end # class EmptyRightOperand

          class OneRightOperand < self
            include Enumerable::OneRightOperand

            def optimize
              Veritas::Logic::Predicate::Inequality.new(left, right.first)
            end

          end # class OneRightOperand

          Veritas::Logic::Predicate::Exclusion.optimizer = chain(
            ConstantOperands,
            EmptyRightOperand,
            OneRightOperand,
            UnoptimizedOperand
          )

        end # class Exclusion
      end # class Predicate
    end # module Logic
  end # class Optimizer
end # module Veritas
