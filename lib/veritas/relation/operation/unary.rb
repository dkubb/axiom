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
          relation = self.relation.optimize

          if relation.kind_of?(Relation::Empty)
            relation
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

        def new_empty_relation
          Relation::Empty.new(header)
        end

      end # module Unary
    end # module Operation
  end # class Relation
end # module Veritas
