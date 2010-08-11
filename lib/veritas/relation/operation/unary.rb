module Veritas
  class Relation
    module Operation
      module Unary
        include Veritas::Operation::Unary

        def initialize(operand)
          super
          @header     = operand.header
          @directions = operand.directions
          @predicate  = operand.predicate
        end

        def optimize
          operand = optimize_operand

          if operand.kind_of?(Relation::Empty)
            operand
          elsif operand.kind_of?(Relation::Materialized)
            new_materialized_relation
          elsif !optimized?
            new_optimized_operation
          else
            super
          end
        end

      end # module Unary
    end # module Operation
  end # class Relation
end # module Veritas
