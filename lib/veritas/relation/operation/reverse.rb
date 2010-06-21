module Veritas
  class Relation
    module Operation
      class Reverse < Order
        def self.new(relation)
          assert_ordered_relation(relation)
          super(relation, relation.directions.reverse)
        end

        class << self
        private

          def assert_ordered_relation(relation)
            if relation.directions.empty?
              raise OrderedRelationRequiredError, 'can only reverse an ordered relation'
            end
          end

        end

        def each(&block)
          relation.reverse_each(&block)
          self
        end

        def optimize
          case optimize_relation
            when Reverse then drop_no_op_reverse
            else
              super
          end
        end

        def wrap
          self.class.new(yield(relation))
        end

      private

        def new_optimized_operation
          self.class.new(optimize_relation)
        end

        def drop_no_op_reverse
          optimize_relation.relation
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
