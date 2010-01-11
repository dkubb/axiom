module Veritas
  class Relation
    module Operation
      class Limit < Relation
        attr_reader :relation

        def self.new(relation, limit)
          unless relation.body.kind_of?(Order::Body)
            raise ArgumentError, 'can only limit a relation with an ordered body'
          end

          super
        end

        def initialize(relation, limit)
          @relation, @limit = relation, limit
        end

        def to_int
          @limit
        end

        def header
          @header ||= relation.header
        end

        def body
          @body ||= limit_body
        end

      private

        def limit_body
          body = relation.body
          body.class.new(header, body.take(to_int))
        end

      end # class Limit
    end # module Operation
  end # class Relation
end # module Veritas
