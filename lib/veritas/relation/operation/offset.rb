module Veritas
  class Relation
    module Operation
      class Offset < Relation
        attr_reader :relation

        def self.new(relation, offset)
          unless relation.body.kind_of?(Order::Body)
            raise ArgumentError, 'can only slice a relation with an ordered body'
          end

          super
        end

        def initialize(relation, offset)
          @relation, @offset = relation, offset
        end

        def to_int
          @offset
        end

        def header
          @header ||= relation.header
        end

        def body
          @body ||= offset_body
        end

      private

        def offset_body
          relation = self.relation
          relation.body.class.new(header, relation.drop(to_int))
        end

      end # class Offset
    end # module Operation
  end # class Relation
end # module Veritas
