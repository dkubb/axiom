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
          elsif !optimized?
            new_optimized_operation
          else
            super
          end
        end

      private

        def optimize_operand
          operand.optimize
        end

        def new_optimized_operation
          self.class.new(optimize_operand)
        end

        def optimized?
          optimize_operand.equal?(operand)
        end

        memoize :new_optimized_operation

      end # module Unary
    end # module Operation
  end # class Relation
end # module Veritas
