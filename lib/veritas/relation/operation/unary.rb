module Veritas
  class Relation
    module Operation
      module Unary
        attr_reader :relation

        def initialize(relation)
          @relation = relation
        end

        def header
          @header ||= relation.header
        end

        def directions
          @directions ||= relation.directions
        end

        def optimize
          relation = relation_optimize

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

        def relation_optimize
          @relation_optimize ||= relation.optimize
        end

        def new_optimized_operation
          self.class.new(relation_optimize)
        end

        def optimized?
          !relation_optimize.equal?(relation)
        end

      end # module Unary
    end # module Operation
  end # class Relation
end # module Veritas
