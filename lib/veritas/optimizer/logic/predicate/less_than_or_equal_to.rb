module Veritas
  class Optimizer
    module Logic
      class Predicate
        class LessThanOrEqualTo < self
          include Comparable

          class AlwaysFalse < self
            include Comparable::NeverComparable
            include Predicate::AlwaysFalse

            def optimizable?
              super || GreaterThan::AlwaysTrue.new(operation.inverse).optimizable?
            end

          end # class AlwaysFalse

          class AlwaysTrue < self
            include Predicate::AlwaysTrue

            def optimizable?
              operation = self.operation
              LessThan::AlwaysTrue.new(operation).optimizable? ||
              Equality::AlwaysTrue.new(operation).optimizable?
            end

          end # class AlwaysTrue

          Veritas::Logic::Predicate::LessThanOrEqualTo.optimizer = chain(
            ConstantOperands,
            AlwaysFalse,
            AlwaysTrue,
            NormalizableOperands
          )

        end # class LessThanOrEqualTo
      end # class Predicate
    end # module Logic
  end # class Optimizer
end # module Veritas
