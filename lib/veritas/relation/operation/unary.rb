module Veritas
  class Relation
    module Operation
      module Unary
        include Veritas::Operation::Unary

        def initialize(operand)
          super
          @header     = operand.header
          @directions = operand.directions
        end

      end # module Unary
    end # module Operation
  end # class Relation
end # module Veritas
