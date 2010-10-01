module Veritas
  class Relation
    module Operation
      class Reverse < Order
        def self.new(operand)
          assert_ordered_operand(operand)
          super(operand, operand.directions.reverse)
        end

        def self.assert_ordered_operand(operand)
          if operand.directions.empty?
            raise OrderedRelationRequiredError, 'can only reverse an ordered operand'
          end
        end

        private_class_method :assert_ordered_operand

        def each(&block)
          operand.reverse_each(&block)
          self
        end

      private

        module Methods
          def reverse
            Reverse.new(self)
          end

        end # module Methods

        Relation.class_eval { include Methods }

      end # class Limit
    end # module Operation
  end # class Relation
end # module Veritas
