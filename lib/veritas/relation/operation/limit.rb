module Veritas
  class Relation
    module Operation
      class Limit < Relation
        include Unary

        def self.new(relation, limit)
#          unless relation.body.kind_of?(Order::Body)
#            raise ArgumentError, 'can only limit a relation with an ordered body'
#          end

          super
        end

        def initialize(relation, limit)
          @limit = limit.to_int
          super(relation)
        end

        def each
          relation.each_with_index do |tuple, index|
            break if @limit == index
            yield tuple
          end
          self
        end

      end # class Limit
    end # module Operation
  end # class Relation
end # module Veritas
