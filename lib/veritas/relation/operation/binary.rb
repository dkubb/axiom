module Veritas
  class Relation
    module Operation
      module Binary
        include Veritas::Operation::Binary

        def self.included(klass)
          klass.extend ClassMethods
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
            left_empty  = left.directions.empty?
            right_empty = right.directions.empty?

            if !left_empty && right_empty
              raise RelationMismatchError, 'left is ordered, and right is not, both relations must be ordered or neither'
            elsif left_empty && !right_empty
              raise RelationMismatchError, 'right is ordered, and left is not, both relations must be ordered or neither'
            end

            super
          end
        end

      end # module Binary
    end # module Operation
  end # class Relation
end # module Veritas
