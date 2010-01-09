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
          @relation, @offset = relation, offset.to_int
        end

        def to_int
          @offset
        end

        def header
          @header ||= relation.header
        end

        def body
          @body ||= relation.body.class.new(header, offset_body)
        end

      private

        def offset_body
          # XXX: can this be turned into an Enumerable that only
          # evaluates once #each is called on it
          tuples = []
          relation.each_with_index do |tuple, index|
            tuples << tuple if index >= to_int
          end
          tuples
        end

      end # class Offset
    end # module Operation
  end # class Relation
end # module Veritas
