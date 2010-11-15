module Veritas
  class Optimizer
    module Relation
      module Operation
        class Combine < Binary
          def optimize
            Veritas::Relation::Empty.new(operation.header)
          end

          class EmptyLeft < self
            include Binary::EmptyLeft
          end # class EmptyLeft

          class EmptyRight < self
            include Binary::EmptyRight
          end # class EmptyRight
        end # class Combine
      end # module Operation
    end # module Relation
  end # class Optimizer
end # module Veritas
