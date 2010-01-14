module Veritas
  class Relation
    module Operation
      class Order
        class Body < Relation::Body
          def initialize(tuples, directions)
            @directions = directions
            super(tuples, tuples.header)
          end

          def each(&block)
            @directions.sort(@tuples).each(&block)
            self
          end

        end # class Body
      end # class Order
    end # module Operation
  end # class Relation
end # module Veritas
