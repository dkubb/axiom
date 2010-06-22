module Veritas
  class Relation
    module Operation
      module Binary
        include Veritas::Operation::Binary

        def self.included(descendant)
          descendant.extend ClassMethods
        end

        def header
          @header ||= left.header | right.header
        end

        def directions
          @directions ||= left.directions | right.directions
        end

        def predicate
          @predicate ||= left.predicate & right.predicate
        end

        def optimize
          optimized? ? new_optimized_operation : super
        end

        def wrap
          self.class.new(yield(left), yield(right))
        end

      private

        def optimize_left
          @optimize_left ||= left.optimize
        end

        def optimize_right
          @optimize_right ||= right.optimize
        end

        def new_optimized_operation
          self.class.new(optimize_left, optimize_right)
        end

        def optimized?
          !(optimize_left.equal?(left) && optimize_right.equal?(right))
        end

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
