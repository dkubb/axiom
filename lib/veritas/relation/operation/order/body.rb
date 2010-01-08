module Veritas
  class Relation
    module Operation
      class Order
        class Body < Relation::Body
          def initialize(header, tuples)
            @header = header
            @tuples = tuples.map { |tuple| Tuple.coerce(@header, tuple) }
          end
        end # class OrderedBody
      end # class Order
    end # module Operation
  end # class Relation
end # module Veritas
