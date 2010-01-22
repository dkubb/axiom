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
          elsif !relation.equal?(self.relation)
            new(relation)
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

        def new(relation)
          self.class.new(relation)
        end

      end # module Unary
    end # module Operation
  end # class Relation
end # module Veritas
