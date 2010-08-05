module Veritas
  class Relation
    module Operation
      class Reverse < Order
        def self.new(operand)
          assert_ordered_operand(operand)
          super(operand, operand.directions.reverse)
        end

        class << self
        private

          def assert_ordered_operand(operand)
            if operand.directions.empty?
              raise OrderedRelationRequiredError, 'can only reverse an ordered operand'
            end
          end

        end

        def each(&block)
          operand.reverse_each(&block)
          self
        end

        def optimize
          case optimize_operand
            when Reverse then drop_no_op_reverse
            else
              super
          end
        end

        def wrap
          new(yield(optimize_operand))
        end

      private

        def new(operand)
          self.class.new(operand)
        end

        def drop_no_op_reverse
          optimize_operand.operand
        end

        memoize :new_optimized_operation

        module Methods
          def reverse
            Operation::Reverse.new(self)
          end

        end # module Methods

        Relation.class_eval { include Methods }

      end # class Limit
    end # module Operation
  end # class Relation
end # module Veritas
