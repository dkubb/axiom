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

        def eql?(other)
          instance_of?(other.class) &&
          relation.eql?(other.relation)
        end

        def hash
          relation.hash
        end

      end # module Unary
    end # module Operation
  end # class Relation
end # module Veritas
