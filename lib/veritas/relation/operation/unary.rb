module Veritas
  class Relation
    module Operation

      # A mixin for Unary relations
      module Unary
        include Veritas::Operation::Unary

        # Initialize a Unary relation
        #
        # @param [Relation] operand
        #
        # @return [undefined]
        #
        # @api private
        def initialize(operand)
          super
          @header     = operand.header
          @directions = operand.directions
        end

      end # module Unary
    end # module Operation
  end # class Relation
end # module Veritas
