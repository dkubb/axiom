module Veritas
  class Optimizer
    module Logic
      class Predicate
        class GreaterThanOrEqualTo < self
          include Comparable

          class AlwaysFalse < self
            include Comparable::NeverComparable
            include Predicate::AlwaysFalse

            def optimizable?
              super || LessThan::AlwaysTrue.new(operation.complement).optimizable?
            end

          end # class AlwaysFalse

          class AlwaysTrue < self
            include Predicate::AlwaysTrue

            def optimizable?
              operation = self.operation
              GreaterThan::AlwaysTrue.new(operation).optimizable? ||
              Equality::AlwaysTrue.new(operation).optimizable?
            end

          end # class AlwaysTrue

          Veritas::Logic::Predicate::GreaterThanOrEqualTo.optimizer = chain(
            ConstantOperands,
            AlwaysFalse,
            AlwaysTrue,
            NormalizableOperands
          )

        end # class GreaterThanOrEqualTo
      end # class Predicate
    end # module Logic
  end # class Optimizer
end # module Veritas
