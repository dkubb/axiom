module Veritas
  class Optimizer
    module Relation
      module Operation
        class Combine < Binary
          class EmptyLeft < self
            include Binary::EmptyLeft

            def optimize
              Veritas::Relation::Empty.new(operation.header)
            end

          end # class EmptyLeft

          class EmptyRight < self
            include Binary::EmptyRight

            def optimize
              Veritas::Relation::Empty.new(operation.header)
            end

          end # class EmptyRight
        end # class Combine
      end # module Operation
    end # module Relation
  end # class Optimizer
end # module Veritas
