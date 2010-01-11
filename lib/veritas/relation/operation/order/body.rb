module Veritas
  class Relation
    module Operation
      class Order
        class Body < Relation::Body
          def limit(limit)
            new(take(limit))
          end
        end # class OrderedBody
      end # class Order
    end # module Operation
  end # class Relation
end # module Veritas
