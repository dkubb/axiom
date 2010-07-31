module Veritas
  class Relation
    module Operation
      module Binary
        include Immutable
        include Veritas::Operation::Binary

        def self.included(descendant)
          descendant.extend ClassMethods
        end

        def initialize(left, right)
          super
          @header     = left.header     | right.header
          @directions = left.directions | right.directions
          @predicate  = left.predicate  & right.predicate
        end

        def optimize
          optimized? ? super : new_optimized_operation
        end

        def wrap
          self.class.new(yield(optimize_left), yield(optimize_right))
        end

      private

        def optimize_left
          left.optimize
        end

        def optimize_right
          right.optimize
        end

        def new_optimized_operation
          self.class.new(optimize_left, optimize_right)
        end

        def optimized?
          optimize_left.equal?(left) && optimize_right.equal?(right)
        end

        memoize :new_optimized_operation

        module ClassMethods
          def new(left, right)
            assert_ordered_match(left, right)
            super
          end

        private

          def assert_ordered_match(left, right)
            if left.directions.empty? != right.directions.empty?
              raise RelationMismatchError, 'both relations must be ordered or neither may be ordered'
            end
          end

        end # module ClassMethods
      end # module Binary
    end # module Operation
  end # class Relation
end # module Veritas
