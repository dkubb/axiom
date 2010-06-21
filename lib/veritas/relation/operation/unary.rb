module Veritas
  class Relation
    module Operation
      module Unary
        include Immutable

        attr_reader :relation

        def initialize(relation)
          @relation = relation
        end

        def header
          relation.header
        end

        def directions
          relation.directions
        end

        def predicate
          relation.predicate
        end

        def optimize
          relation = optimize_relation

          if relation.kind_of?(Relation::Empty)
            relation
          elsif optimized?
            new_optimized_operation
          else
            super
          end
        end

        def eql?(other)
          instance_of?(other.class) &&
          relation.eql?(other.relation)
        end

        def hash
          relation.hash
        end

      private

        def optimize_relation
          relation.optimize
        end

        def new_optimized_operation
          self.class.new(optimize_relation)
        end

        def optimized?
          !optimize_relation.equal?(relation)
        end

        memoize :new_optimized_operation

      end # module Unary
    end # module Operation
  end # class Relation
end # module Veritas
