module Veritas
  class Relation
    module Operation
      class Order
        class Body < Relation::Body
          def limit(limit)
            self.class.new(take(limit), header)
          end

          def offset(offset)
            self.class.new(drop(offset), header)
          end
        end # class OrderedBody
      end # class Order
    end # module Operation
  end # class Relation
end # module Veritas
