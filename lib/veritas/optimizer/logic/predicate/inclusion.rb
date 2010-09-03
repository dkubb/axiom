module Veritas
  class Optimizer
    module Logic
      class Predicate
        class Inclusion < self
          include Enumerable

          class EmptyRightOperand < self
            include Enumerable::EmptyRightOperand

            def optimize
              Veritas::Logic::Proposition::False.instance
            end

          end # class EmptyRightOperand

          class OneRightOperand < self
            include Enumerable::OneRightOperand

            def optimize
              Veritas::Logic::Predicate::Equality.new(left, right.first)
            end

          end # class OneRightOperand

          Veritas::Logic::Predicate::Inclusion.optimizer = chain(
            ConstantOperands,
            EmptyRightOperand,
            OneRightOperand,
            UnoptimizedOperand
          )

        end # class Inclusion
      end # class Predicate
    end # module Logic
  end # class Optimizer
end # module Veritas
