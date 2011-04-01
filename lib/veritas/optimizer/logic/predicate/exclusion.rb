module Veritas
  class Optimizer
    module Logic
      class Predicate

        # Abstract base class representing Exclusion optimizations
        class Exclusion < self
          include Enumerable

          # Optimize when the right operand is empty
          class EmptyRightOperand < self
            include Enumerable::EmptyRightOperand

            # An Exclusion with an empty right operand matches everything
            #
            # @return [True]
            #
            # @api private
            def optimize
              Veritas::Logic::Proposition::True.instance
            end

          end # class EmptyRightOperand

          # Optimize when the right operand has one entry
          class OneRightOperand < self
            include Enumerable::OneRightOperand

            # An Exclusion with a single right operand is equivalent to an Inequality
            #
            # @return [Inequality]
            #
            # @api private
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
